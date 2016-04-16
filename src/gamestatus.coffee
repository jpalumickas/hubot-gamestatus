# Description
#   Show detail information about game server.
#
# Commands:
#   hubot show <game_type> game status for <server_address> - Show information about game server.
#   hubot add <name> game server <game_type> <server_address> - Add game server to the list.
#   hubot show game servers - Show your all game servers.
#   hubot remove <name> game server - Removes game server from the list.
#   hubot show <name> server information - Show all information about game server.
#   hubot show <name> server players - Show currently playing players in the game server.
#
# Author:
#   Justas Palumickas [jpalumickas@gmail.com]

gamedig = require('gamedig')
_ = require('lodash')

module.exports = (robot) ->

  robot.brain.on 'loaded', =>
    robot.brain.data.game_servers ||= []

  robot.respond /show (.+) game status for (.+)/, (msg) ->
    print_server_information(msg.match[1], msg.match[2], msg)

  robot.respond /show game servers/, (msg) ->
    if robot.brain.data.game_servers.length < 1
      return msg.send "There is no game servers in the list. Please add one."

    messages = _.map robot.brain.data.game_servers, (server, index) ->
      return "#{index+1}. #{server.name} (#{server.address}) Game type: #{server.game_type}"

    msg.send messages.join("\n")

  robot.respond /add (.+) game server (.+) (.+)/, (msg) ->
    server = {
      name: msg.match[1],
      game_type: msg.match[2],
      address: msg.match[3],
    }

    robot.brain.data.game_servers.push(server)
    msg.send "Server \"#{server.name}\" have been added to the list."

  robot.respond /(remove|rem|delete) (.+) game server/, (msg) ->
    server = _.find robot.brain.data.game_servers, (server) ->
      return server.name == msg.match[2]

    return msg.send "I don't know anything about \"#{msg.match[2]}\" server" unless server

    robot.brain.data.game_servers = _.reject robot.brain.data.game_servers, (serv) ->
      serv.name == server.name

    msg.send "Server \"#{server.name}\" have been removed from the list."

  robot.respond /show (.+) server (info|information)/, (msg) ->
    server = _.find robot.brain.data.game_servers, (server) ->
      return server.name == msg.match[1]

    return msg.send "I don't know anything about \"#{msg.match[1]}\" server" unless server

    print_server_information(server.game_type, server.address, msg)

  robot.respond /show (.+) server players/, (msg) ->
    server = _.find robot.brain.data.game_servers, (server) ->
      return server.name == msg.match[1]

    return msg.send "I don't know anything about \"#{msg.match[1]}\" server" unless server

    print_server_players(server.game_type, server.address, msg)

  # Return server parameters for Gamedig
  server_params = (game_type, server_address) ->
    server_address = server_address.split(':')
    host = server_address[0]
    port = server_address[1]

    params = { type: game_type, host: host }
    params.port = parseInt(port) if port

    return params

  print_server_players = (game_type, server_address, msg) ->
    Gamedig.query server_params(game_type, server_address), (state) ->
      return msg.send("Server is offline.") if state.error

      if state.players.length < 1
        return msg.send "There is no players in this server at this moment."

      messages = ['Players:']
      _.each state.players, (player, index) ->
        messages.push "#{index+1}. #{player.name} (Score: #{player.score}, Time: #{player.time})"

      msg.send messages.join("\n")
      return

  print_server_information = (game_type, server_address, msg) ->
    Gamedig.query server_params(game_type, server_address), (state) ->
      if state.error
        msg.send "Server is offline."
      else
        msg.send [
          state.name,
          "Map: #{state.map}",
          "Players #{state.raw.numplayers}/#{state.maxplayers}"
        ].join("\n")
      return
