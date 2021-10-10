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
	"github.com/alexmeuer/secret-santa-list/internal/serve/gqlact"
	"github.com/spf13/cobra"
)

// gqlCmd represents the gql command
var gqlCmd = &cobra.Command{
	Use:   "gql",
	Short: "Serve the tracker as a web server which expects to be invoked by GraphQL actions.",
	Long: `Serve the secret santa list tracker as a web server which expects to be invoked by
Graphql actions. Generally, this is the command that is used in tandem with docker-compose.`,
	RunE: func(cmd *cobra.Command, args []string) error {
		return gqlact.Serve(port, hasuraEndpoint, hasuraSecret)
	},
}

func init() {
	serveCmd.AddCommand(gqlCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// gqlCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// gqlCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
