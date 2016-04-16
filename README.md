# Hubot Game Status

[![NPM Version](https://img.shields.io/npm/v/hubot-gamestatus.svg?maxAge=2592000&style=flat-square)][npmjs]

Show detail information about game server


## Installation

In hubot project repo, run:

```sh
npm install hubot-gamestatus --save
```

Then add **hubot-gamestatus** to your `external-scripts.json`:

```json
["hubot-gamestatus"]
```

## Usage

#### Show information about game server
`hubot show <game_type> game status for <server_address>`

#### Add game server to the list
`hubot add <name> game server <game_type> <server_address>`

#### Show your all game servers
`hubot show game servers`

#### Removes game server from the list
`hubot remove <name> game server`

#### Show all information about game server
`hubot show <name> server information`

##### Show currently playing players in the game server
`hubot show <name> server players`

## Copyright
Copyright (c) 2014-2016 Justas Palumickas.
See [LICENSE][license] for details.

[npmjs]: https://www.npmjs.com/package/hubot-gamestatus
[license]: https://raw.githubusercontent.com/jpalumickas/hubot-gamestatus/master/LICENSE
