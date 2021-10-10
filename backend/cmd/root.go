/*
Copyright © 2021 Alexander Meuer <alex@alexmeuer.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.
*/
package cmd

import (
	"fmt"
	"os"
	"path"
	"strings"
	"time"

	"github.com/rs/zerolog"
	"github.com/spf13/cobra"
	"github.com/spf13/pflag"

	"github.com/spf13/viper"
)

const envPrefix = "SANTA"

var cfgFile string
var hasuraEndpoint string
var hasuraSecret string
var verbose bool
var quiet bool

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use: "secret-santa-list",
	Long: `A Secret-Santa list tracker.

You can provide configuration by way of a config file, cli flags,
or by environment variables (with the 'SANTA_' prefix).`,
	PersistentPreRunE: func(cmd *cobra.Command, args []string) error {
		// You can bind cobra and viper in a few locations, but PersistencePreRunE on the root command works well
		if err := initializeConfig(cmd); err != nil {
			return err
		}
		if verbose {
			zerolog.SetGlobalLevel(zerolog.DebugLevel)
		} else if quiet {
			zerolog.SetGlobalLevel(zerolog.ErrorLevel)
		} else {
			zerolog.SetGlobalLevel(zerolog.InfoLevel)
		}
		zerolog.LevelFieldName = "severity"
		zerolog.TimestampFieldName = "timestamp"
		zerolog.TimeFieldFormat = time.RFC3339Nano
		return nil
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	cobra.CheckErr(rootCmd.Execute())
}

func init() {
	rootCmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $XDG_CONFIG_HOME/.secret-santa-list.yaml)")
	rootCmd.PersistentFlags().BoolVarP(&verbose, "verbose", "v", false, "Enables verbose logging output. If both verbose and quiet are specified, verbose is given priority.")
	rootCmd.PersistentFlags().BoolVarP(&quiet, "quiet", "q", false, "Disables all log levels above ERROR. If verbose is also specified, it will take priority.")
	rootCmd.PersistentFlags().StringVar(&hasuraEndpoint, "hasura-endpoint", "", "The endpoint of the Hasura GraphQL service.")
	rootCmd.PersistentFlags().StringVar(&hasuraSecret, "hasura-admin-secret", "", "The admin secret for the Hasura endpoint.")
}

func initializeConfig(cmd *cobra.Command) error {
	v := viper.New()
	if cfgFile != "" {
		// Use config file from the flag.
		v.SetConfigFile(cfgFile)
	} else {
		cfgDir, err := os.UserConfigDir()
		if err != nil {
			v.AddConfigPath(path.Join(cfgDir, "juke"))
		}
		v.AddConfigPath(".")
		v.SetConfigName("juke")
	}

	// When we bind flags to environment variables expect that the
	// environment variables are prefixed, e.g. a flag like --number
	// binds to an environment variable SANTA_NUMBER. This helps
	// avoid conflicts.
	v.SetEnvPrefix(envPrefix)

	// Bind to environment variables
	// Works great for simple config names, but needs help for names
	// like --favorite-color which we fix in the bindFlags function
	v.AutomaticEnv()

	// Attempt to read the config file, gracefully ignoring errors
	// caused by a config file not being found. Return an error
	// if we cannot parse the config file.
	if err := v.ReadInConfig(); err != nil {
		// It's okay if there isn't a config file
		if _, ok := err.(viper.ConfigFileNotFoundError); !ok {
			return err
		}
	}

	bindFlags(cmd, v)

	return nil
}

func bindFlags(cmd *cobra.Command, v *viper.Viper) {
	bindAll := func(fset *pflag.FlagSet) {
		fset.VisitAll(func(f *pflag.Flag) {
			// Environment variables can't have dashes in them, so bind them to their equivalent
			// keys with underscores, e.g. --favorite-color to SANTA_FAVORITE_COLOR
			if strings.Contains(f.Name, "-") {
				envVarSuffix := strings.ToUpper(strings.ReplaceAll(f.Name, "-", "_"))
				v.BindEnv(f.Name, fmt.Sprintf("%s_%s", envPrefix, envVarSuffix))
			}
			// Apply the viper config value to the flag when the flag is not set and viper has a value
			if !f.Changed && v.IsSet(f.Name) {
				val := v.Get(f.Name)
				fset.Set(f.Name, fmt.Sprintf("%v", val))
			}
		})
	}
	bindAll(cmd.PersistentFlags())
	bindAll(cmd.Flags())
}
