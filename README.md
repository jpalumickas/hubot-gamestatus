# Hubot-GameStatus

Show detail information about game server.

See [`src/gamestatus.coffee`](src/gamestatus.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-gamestatus --save`

Then add **hubot-gamestatus** to your `external-scripts.json`:

```json
["hubot-gamestatus"]
```

## Commands:
`hubot show <game_type> game status for <server_address>` - Show information about game server.

`hubot show game servers` - Show your all game servers.

`hubot add <name> game server <game_type> <server_address>` - Add game server to the list.

`hubot remove <name> game server` - Removes game server from the list.

`hubot show <name> server information` - Show all information about game server.

`hubot show <name> server players` - Show currently playing players in the game server.
