-- initial run: pm2 start main.lua --interpreter ./luvit -n mybotname && pm2 save
-- subsequent: pm2 restart mybotname or pm2 stop mybotname or pm2 start mybotname
local discordia = require('discordia')
local timer = require('timer')
local http = require("http")
local https = require("https")
local client = discordia.Client()
local json = require('json')
local Utopia = require('utopia')
local bodyParser = require('body-parser')
local pathJoin = require('luvi').path.join
local fs = require('fs')
math.randomseed(os.time())
local token = "add your bot token here"
local saleTotal = 0
local Spam = {}
local Flower_Poker = {}
local Flowers = {
  [1] = {
    name = "Red Flowers",
    icon = "<:Red_Flowers:790763271472808006>"
  },
  [2] = {
    name = "Blue Flowers",
    icon = "<:Blue_Flowers:790763271422083112>"
  },
  [3] = {
    name = "Yellow Flowers",
    icon = "<:Yellow_Flowers:790763271492993034>"
  },
  [4] = {
    name = "Orange Flowers",
    icon = "<:Orange_Flowers:790763271446593536>"
  },
  [5] = {
    name = "Black Flowers",
    icon = "<:Black_Flowers:790763271413170186>"
  },
  [6] = {
    name = "Pastel Flowers",
    icon = "<:Pastel_Flowers:790763271489585192>"
  },
  [7] = {
    name = "Rainbow Flowers",
    icon = "<:Rainbow_Flowers:790763271560888360>"
  },
  [8] = {
    name = "White Flowers",
    icon = "<:White_Flowers:790763271439384587>"
  }
}
local Flower_Rolls = {}
local app = Utopia:new()

-- parse application/x-www-form-urlencoded
app:use(bodyParser.urlencoded())

-- parse application/json
app:use(bodyParser.json())

app:listen(30120)


local config = require("/home/luvit/RSBot/skills/config.lua")

local Prices = {
  ['Copper Ore'] = 100, ['Coal Ore'] = 350, ['Runite Ore'] = 625, --minig skill
  ["Willow Log"] = 90, ["Yew Log"] = 325, ["Magic Log"] = 725, --woodcutting skill
  ["Raw Shrimp"] = 72, ["Raw Lobster"] = 265, ["Raw Shark"] = 825, --fishing skill
  ["Bronze Bar"] = 110, ["Gold Bar"] = 420, ["Rune Bar"] = 1125, --smithing skill
  ["Attack Potion"] = 150, ["Prayer Potion"] = 425, ["Anti-Venom+"] = 1200, -- herblore skill
  ["Cup Of Tea"] = 35, ["Strawberry Seed"] = 215, ["Diamond"] = 765, --thieving skill
  ["Leather Gloves"] = 95, ["Snakeskin Bandana"] = 385, ["Black Dragonhide Body"] = 1050, --crafting skill
  ["Arrow Shaft"] = 52, ["Mithril Arrow"] = 275, ["Magic Shortbow"] = 825, --fletching skill
  ["Baby Impling Jar"] = 90, ["Dragon Impling Jar"] = 415, ["Lucky Impling Jar"] = 1250, --hunter skill
  ["Oak Logs"] = 0, ["Maple Logs"] = 0, ["Magic Logs"] = 0, --farming skill
  ["Air Runes"] = 57, ["Nature Runes"] = 325, ["Blood Runes"] = 925, --runecrafting skill
  ["Tuna"] = 125, ["Swordfish"] = 455, ["Manta Ray"] = 1450, --cooking skill
}

local Skills = {
  "attack", "strength", "defence", "range", "magic", "prayer", "hitpoint", "runecrafting", "construction", "agility", "thieving", 
  "herblore", "crafting", "fletching", "slayer", "hunter", "mining", "smithing", "fishing", "cooking", "firemaking", "woodcutting",  "farming",
}

local action_to_skill = config.action_to_skill
local skill_data = config.skill_data

function print_table(node)
  local cache, stack, output = {},{},{}
  local depth = 1
  local output_str = "{\n"

  while true do
      local size = 0
      for k,v in pairs(node) do
          size = size + 1
      end

      local cur_index = 1
      for k,v in pairs(node) do
          if (cache[node] == nil) or (cur_index >= cache[node]) then

              if (string.find(output_str,"}",output_str:len())) then
                  output_str = output_str .. ",\n"
              elseif not (string.find(output_str,"\n",output_str:len())) then
                  output_str = output_str .. "\n"
              end

              -- This is necessary for working with HUGE tables otherwise we run out of memory using concat on huge strings
              table.insert(output,output_str)
              output_str = ""

              local key
              if (type(k) == "number" or type(k) == "boolean") then
                  key = "["..tostring(k).."]"
              else
                  key = "['"..tostring(k).."']"
              end

              if (type(v) == "number" or type(v) == "boolean") then
                  output_str = output_str .. string.rep('\t',depth) .. key .. " = "..tostring(v)
              elseif (type(v) == "table") then
                  output_str = output_str .. string.rep('\t',depth) .. key .. " = {\n"
                  table.insert(stack,node)
                  table.insert(stack,v)
                  cache[node] = cur_index+1
                  break
              else
                  output_str = output_str .. string.rep('\t',depth) .. key .. " = '"..tostring(v).."'"
              end

              if (cur_index == size) then
                  output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
              else
                  output_str = output_str .. ","
              end
          else
              -- close the table
              if (cur_index == size) then
                  output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
              end
          end

          cur_index = cur_index + 1
      end

      if (size == 0) then
          output_str = output_str .. "\n" .. string.rep('\t',depth-1) .. "}"
      end

      if (#stack > 0) then
          node = stack[#stack]
          stack[#stack] = nil
          depth = cache[node] == nil and depth + 1 or depth - 1
      else
          break
      end
  end

  table.insert(output,output_str)
  output_str = table.concat(output)

  print(output_str)
end
function string.gen(numLetters)
local totTxt = ""
  for i = 1,numLetters do
      totTxt = totTxt..string.char(math.random(97,122))
  end
  return(totTxt)
end

function Notify(message, preset)
  if preset == 'spam' then
    message.channel:send(message.author.username..' Please complete your action before starting a new one.')  
  end
  if preset == 'inventory' then
    message.channel:send(message.author.username..' your inventory is full.')  
  end
  if preset == 'herblore' then
    message.channel:send(message.author.username..' is mixing.. Please wait.  ')  
  end
  if preset == 'thieving' then
    message.channel:send(message.author.username..' is stealing.. Please wait.  ')  
  end
  if preset == 'crafting' then
    message.channel:send(message.author.username..' is crafting.. Please wait.  ')  
  end
  if preset == 'fletching' then
    message.channel:send(message.author.username..' is fletching.. Please wait.  ')  
  end
  if preset == 'runecrafting' then
    message.channel:send(message.author.username..' is runecrafting.. Please wait.  ')  
  end
  if preset == 'farming' then
    message.channel:send(message.author.username..' is farming.. Please wait.  ')  
  end
  if preset == 'agility' then
    message.channel:send(message.author.username..' is running.. Please wait.  ')  
  end
  if preset == 'cooking' then
    message.channel:send(message.author.username..' is cooking.. Please wait.  ')  
  end
  if preset == 'mining' then
    message.channel:send(message.author.username..' is mining.. Please wait.  ')  
  end
  if preset == 'fishing' then
    message.channel:send(message.author.username..' is fishing.. Please wait.  ')  
  end
  if preset == 'woodcutting' then
    message.channel:send(message.author.username..' is woodcutting.. Please wait.  ')  
  end
  if preset == 'register_first' then
    message.channel:send(message.author.username..' type r.register before playing.')
  end
  if preset == 'register_success' then
    message.channel:send(message.author.username..' registered successfully.')
  end
  if preset == 'register_fail' then
    message.channel:send(message.author.username..' is already registered.')
  end
  if preset == 'sell' then
    message.channel:send(message.author.username..' sold some items for '..Money_f(saleTotal)..' gp')
    saleTotal = 0
  end
  if preset == 'staff' then
    message.channel:send(message.author.username..' you must be an administrator to do this.')
  end
  if preset == 'style-fail' then
    message.channel:send(message.author.username..' This is an invalid attack style type r.help for suggestions.')
  end
end

function flower_format(i)
  if tonumber(i) == 5 then
    return "Nothing"
  end
  if tonumber(i) == 7 then
    return "One Pair"
  end
  if tonumber(i) == 9 then
    return "Two pairs"
  end
  if tonumber(i) == 11 then
    return "Three of a kind"
  end
  if tonumber(i) == 13 then
    return "Full house"
  end
  if tonumber(i) == 17 then
    return "Four of a kind"
  end
  if tonumber(i) == 25 then
    return "Five of a kind"
  end
end

function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end

function SaveTable(t, filename)
  local file = io.open("/home/luvit/RSBot/accounts/"..filename.."", "w")

    if file then
        local contents = json.encode(t)
        file:write( contents )
        io.close( file )
        return true
    else
        return false
    end
end

function LoadTable(filename)
    local contents = ""
    local dataTable = {}
    local file, err = io.open( "/home/luvit/RSBot/accounts/"..filename.."", "r" )
    if file then
      local contents = file:read( "*a" )
      dataTable = json.decode(contents);
      io.close( file )
      return dataTable
    end
    return nil
end

function Money_f(n)
  if n >= 10^9 then
    return string.format("%.2fB", n / 10^9)
  elseif n >= 10^6 then
    return string.format("%.2fM", n / 10^6)
  elseif n >= 10^3 then
    return string.format("%.2fK", n / 10^3)
  else
      return tostring(n)
  end
end

function Calculate(xp) -- credit to heyden/heydoon#8324 for making the convertion stuff possible(Calculate(), Level2XP(), XP2Level(), XP4Level())
  return math.floor(xp + 300 * 2 ^ (xp / 7))
end

function Level2XP(level)
  local xp = 0

  for i = 1, level do
      xp = xp + Calculate(i)
  end
  return math.floor(xp / 4)
end

function XP2Level(xp)
  local level = 1

  while (Level2XP(level) <= xp) do
      level = level + 1
  end
  return level
end

function XP4Level(current_xp)
local current_level = XP2Level(current_xp)
local next_level_xp = Level2XP(current_level)
local xp_until_level = next_level_xp - current_xp
  return xp_until_level
end

function AddItem(id, item, amount)
  if amount == nil then
    amount = 1
  end
  local data = LoadTable("accounts.json")
  if data[id]['inventory'][item] ~= nil then
    data[id]['inventory'][item] = data[id]['inventory'][item]+amount
  end
  SaveTable(data, "accounts.json")
end

function GetTotalLevel(id)
  local data = LoadTable("accounts.json")
  local totals = 0
  for skill, exp in pairs(data[id].statistics) do
    totals = totals+XP2Level(tonumber(exp))
    end
  return totals
end

function Combatlvl(attack, strength, defence, magic, range, prayer, hitpoint)
local base = 0.25*(defence+hitpoint+math.floor(prayer/2))
local melee = 0.325*(attack+strength)
local range = 0.325*(math.floor(range/2) + range)
local magic = 0.325*(math.floor(magic/2) + magic)

if magic > melee or magic > range then
local final = math.floor(base+magic)
  return final 
end

if melee > magic or melee > range then
  local final = math.floor(base+melee)
    return final 
  end
  if range > melee or range > magic then
    local final = math.floor(base+range)
      return final 
  end
end

function Statistics(message)
  local data = LoadTable("accounts.json")
  local id = tostring(message.author.id)
  local totals = GetTotalLevel(message.author.id)
  local attack, defence, strength, hitpoints, range, magic, prayer, runecrafting,construction,agility,herblore,thieving,crafting,fletching,slayer,hunter,mining,smithing,fishing,cooking,firemaking,woodcutting,farming = nil
  local combatLvl = Combatlvl(XP2Level(data[id]['statistics']['attack']), XP2Level(data[id]['statistics']['strength']), XP2Level(data[id]['statistics']['defence']), XP2Level(data[id]['statistics']['magic']), XP2Level(data[id]['statistics']['range']), XP2Level(data[id]['statistics']['prayer']), XP2Level(data[id]['statistics']['hitpoint']))
  local totalXP = data[id]['statistics']['attack']+data[id]['statistics']['defence']+data[id]['statistics']['strength']+data[id]['statistics']['hitpoint']+data[id]['statistics']['range']+data[id]['statistics']['magic']+data[id]['statistics']['prayer']+data[id]['statistics']['runecrafting']+data[id]['statistics']['construction']+data[id]['statistics']['agility']+data[id]['statistics']['herblore']+data[id]['statistics']['thieving']+data[id]['statistics']['crafting']+data[id]['statistics']['fletching']+data[id]['statistics']['slayer']+data[id]['statistics']['hunter']+data[id]['statistics']['mining']+data[id]['statistics']['smithing']+data[id]['statistics']['fishing']+data[id]['statistics']['cooking']+data[id]['statistics']['firemaking']+data[id]['statistics']['woodcutting']+data[id]['statistics']['farming']
        attack = XP2Level(data[id]['statistics']['attack'])
        defence = XP2Level(data[id]['statistics']['defence'])
        strength = XP2Level(data[id]['statistics']['strength'])
        hitpoints = XP2Level(data[id]['statistics']['hitpoint'])
        range = XP2Level(data[id]['statistics']['range'])
        magic = XP2Level(data[id]['statistics']['magic'])
        prayer = XP2Level(data[id]['statistics']['prayer'])
        runecrafting = XP2Level(data[id]['statistics']['runecrafting'])
        construction = XP2Level(data[id]['statistics']['construction'])
        agility = XP2Level(data[id]['statistics']['agility'])
        herblore = XP2Level(data[id]['statistics']['herblore'])
        thieving = XP2Level(data[id]['statistics']['thieving'])
        crafting = XP2Level(data[id]['statistics']['crafting'])
        fletching = XP2Level(data[id]['statistics']['fletching'])
        slayer = XP2Level(data[id]['statistics']['slayer'])
        hunter = XP2Level(data[id]['statistics']['hunter'])
        mining = XP2Level(data[id]['statistics']['mining'])
        smithing = XP2Level(data[id]['statistics']['smithing'])
        fishing = XP2Level(data[id]['statistics']['fishing'])
        cooking = XP2Level(data[id]['statistics']['cooking'])
        firemaking = XP2Level(data[id]['statistics']['firemaking'])
        woodcutting = XP2Level(data[id]['statistics']['woodcutting'])
        farming = XP2Level(data[id]['statistics']['farming'])

  if totals ~= nil then
    message:reply {
      embed = {
        title = "Combat Level: "..combatLvl,
        author = {
          name = message.author.tag,
          icon_url = message.author.avatarURL
        },
        fields = {
          {
            name = "Total Exp: "..Money_f(totalXP),
            value = ""..
            "<:Attack:784545972419821568> **"..attack.."/99** | <:Hitpoints:784545972377092126> **"..hitpoints.."/99** | <:Mining:784545971748601927> **"..mining.."/99**\n"..
            "\n<:Strength:784545972222820373> **"..strength.."/99** | <:Agility:784545971991609364> **"..agility.."/99** | <:Smithing:784545972415234048> **"..smithing.."/99**\n"..
            "\n<:Defence:784545972369621002> **"..defence.."/99** | <:Herblore:784545972063699004> **"..herblore.."/99** | <:Fishing:784545972432404510> **"..fishing.."/99**\n"..
            "\n<:range:784545974214590474> **"..range.."/99** | <:Thieving:784545971954384936> **"..thieving.."/99** | <:Cooking:784545972238680117> **"..cooking.."/99**\n"..
            "\n<:Prayer:784545972096335872> **"..magic.."/99** | <:Crafting:784545971966312468> **"..crafting.."/99** | <:Firemaking:784545972432535582> **"..firemaking.."/99**\n"..
            "\n<:Magic:784545972217970709> **"..prayer.."/99** | <:Fletching:784545972427554836> **"..fletching.."/99** | <:Woodcutting:784545972386398248> **"..woodcutting.."/99**\n"..
            "\n<:Runecraft:784545972155711528> **"..runecrafting.."/99** | <:Slayer:784545971949797406> **"..slayer.."/99** | <:Farming:784545972432273418> **"..farming.."/99**\n"..
            "\n<:Construction:784545972390330378> **"..construction.."/99** | <:Hunter:784545972184285216> **"..hunter.."/99**"..
            "",
            inline = true
          }
        },
        footer = {
          text = "You have "..tostring(totals).." total levels.",
        },
        color = 0x34b7eb
      }
    }
  end
end

function FirstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

function CustomXP(id, skill, xp)
  local data = LoadTable("accounts.json")
  for k, v in pairs(Skills) do
      if skill == v then
      data[id]['statistics'][skill] = data[id]['statistics'][skill]+xp
      break
    end
  end
  SaveTable(data, "accounts.json")
end

function AddXp(id, xp)
  local data = LoadTable("accounts.json")
  if xp == 'shared' then
    data[id]['statistics']['hitpoint'] = data[id]['statistics']['hitpoint']+math.random(35, 80)
    data[id]['statistics']['strength'] = data[id]['statistics']['strength']+math.random(135, 155)
    data[id]['statistics']['attack'] = data[id]['statistics']['attack']+math.random(135, 155)
    data[id]['statistics']['defence'] = data[id]['statistics']['defence']+math.random(135, 155)
    data[id]['statistics']['slayer'] = data[id]['statistics']['slayer']+math.random(25, 45)
  end
  if xp == 'stab' then
    data[id]['statistics']['hitpoint'] = data[id]['statistics']['hitpoint']+math.random(105, 115)
    data[id]['statistics']['attack'] = data[id]['statistics']['attack']+math.random(335, 375)
    data[id]['statistics']['slayer'] = data[id]['statistics']['slayer']+math.random(25, 45)
  end
  if xp == 'crush' then
    data[id]['statistics']['hitpoint'] = data[id]['statistics']['hitpoint']+math.random(105, 115)
    data[id]['statistics']['strength'] = data[id]['statistics']['strength']+math.random(335, 375)
    data[id]['statistics']['slayer'] = data[id]['statistics']['slayer']+math.random(25, 45)
  end
  if xp == 'defensive' then
    data[id]['statistics']['hitpoint'] = data[id]['statistics']['hitpoint']+math.random(105, 115)
    data[id]['statistics']['defence'] = data[id]['statistics']['defence']+math.random(335, 375)
    data[id]['statistics']['slayer'] = data[id]['statistics']['slayer']+math.random(25, 45)
  end
  if xp == 'magic' then
    data[id]['statistics']['hitpoint'] = data[id]['statistics']['hitpoint']+math.random(115, 135)
    data[id]['statistics']['magic'] = data[id]['statistics']['magic']+math.random(375, 420)
    data[id]['statistics']['slayer'] = data[id]['statistics']['slayer']+math.random(25, 45)
  end
  if xp == 'range' then
    data[id]['statistics']['hitpoint'] = data[id]['statistics']['hitpoint']+math.random(125, 155)
    data[id]['statistics']['range'] = data[id]['statistics']['range']+math.random(375, 420)
    data[id]['statistics']['slayer'] = data[id]['statistics']['slayer']+math.random(25, 45)
  end
  SaveTable(data, "accounts.json")
end

function AddGold(id, amount)
  local data = LoadTable("accounts.json")
  data[id]['currency']['Gold'] = data[id]['currency']['Gold']+amount
  SaveTable(data, "accounts.json")
end
function AddVotes(id, amount)
  local data = LoadTable("accounts.json")
  print_table(data[id]['currency'])
  data[id]['currency']['Vote Point'] = data[id]['currency']['Vote Point']+amount
  SaveTable(data, "accounts.json")
end
function Vote(message, id)
  message:reply {
    embed = {
      title = "Vote for Runescape Bot",
      author = {
        name = message.author.tag,
        icon_url = message.author.avatarURL 
      },
      fields = {
        {
          name = "Top.gg",
          value = "[Click here to vote](https://top.gg/bot/780896702495588352/vote)",
          inline = true
        },
        {
          name = "Discordbotlist.com",
          value = "[Click here to vote](https://discordbotlist.com/bots/runescape-bot/upvote)",
          inline = false
        }
      },
      footer = {
        text = "Type r.votestatus to check if you are eligible to vote."
      },
      color = 0x2f3136
    }
  }
end

function CheckVote(message, id)
    local topstatus = ""
    local options = {
    host = 'top.gg',
    path = '/api/bots/780896702495588352/check?userId='..id,
    protocol = 'https',
    headers = {
      {'Authorization', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijc4MDg5NjcwMjQ5NTU4ODM1MiIsImJvdCI6dHJ1ZSwiaWF0IjoxNjA3OTA4NTIzfQ.Mz_mEC90Gb80j2mf-JRawbsH4DCdN2AEh3Ch2ziRRyk'}
    }
  }

  local req = https.get(options, function(res)
    res:on('data', coroutine.wrap(function (chunk)
      local data = json.decode(chunk)
        print(data['voted'])
        
      if data['voted'] == 1 then
        topstatus = "Already voted."
      else
        topstatus = "Ready to vote."
      end
      message:reply {
        embed = {
          author = {
            name = message.author.tag,
            icon_url = message.author.avatarURL
          },
          title = "Vote status",
          fields = {
            {name = "Top.gg", value = topstatus, inline = true},
            {name = "Discordbotlist.com", value = "*Status Unavailable*", inline = true},
          },
          color = 0x2f3136,
          timestamp = discordia.Date():toISO('T', 'Z')
        }
      }
        end)
        )
      end)
      req:done()
end

function InvRemove(id, message)
  local data = LoadTable("accounts.json")
  for k, v in pairs(Prices) do
  data[id]['inventory'][k] = 0
  end
  SaveTable(data, "accounts.json")
  Notify(message, "sell")
end

function Sell(id, message)
  local data = LoadTable("accounts.json")
    for item_name, item_count in pairs(data[id]['inventory']) do
      if item_count > 0 then
      saleTotal = saleTotal+(item_count * Prices[item_name])
      AddGold(id, item_count * Prices[item_name])
    end
  end
  InvRemove(id, message)
end

function IsRegistered(message)
local data = LoadTable("accounts.json")
local id = tostring(message.author.id)
local registered = nil
    if data[id] then
      return true
    else
      return false
    end
end

function Flower_code_Lookup(code) 
  for k, v in pairs(Flower_Poker) do
    if code == k then
      return k, Flower_Poker[k]['host_id'], Flower_Poker[k]['host_name'], Flower_Poker[k]['inv_msg'], Flower_Poker[k]['pot'], Flower_Poker[k]['instigator_id'], Flower_Poker[k]['instigator_msg'], Flower_Poker[k]['status']
    end
  end
end

function Register(message)
  local data = LoadTable("accounts.json")
  local id = tostring(message.author.id)
  local registered = IsRegistered(message)
  if registered == false then
    data[id] = require("/home/luvit/RSBot/accounts/structure.lua")
    SaveTable(data, "accounts.json")
    print("registered account for "..message.author.username.."("..id..")")
  elseif registered == true then
    Notify(message, 'register_fail')
  end

end

function GetServers()
  local str = ""
  for k, v in pairs(client.guilds) do
    str = str..", "..v.name  
  end
  return str
end
client:on('ready', function()
  print('Logged in as '.. client.user.username)
  print(#client.guilds.." servers are running the bot"..GetServers())

end)

function Inventory(message)
  local data = LoadTable("accounts.json")
  local id = tostring(message.author.id)
  local money_str = ""
  local inventory_str = ""
  local Money = {
    [id] = {

    }
  }
  local Inventory = {
    [id] = {

    }
  }

  for currency, value in pairs(data[id]['currency']) do
    if value > 0 then
      table.insert(Money[id], { [currency] = Money_f(tonumber(value)) })
    elseif currency == 'Gold' then
      table.insert(Money[id], {['Gold'] = "-69$"})
    end
  end

  for item, value in pairs(data[id]['inventory']) do
    if value > 0 then
      table.insert(Inventory[id], {[item] = value})
    end
  end

  for k, v in pairs(Money[id]) do
      for inv, items in pairs(v) do
        money_str = money_str .. ""..inv..": "..items.." \n"
      end
  end

  for a, b in pairs(Inventory[id]) do
    for items, amount in pairs(b) do
      inventory_str = inventory_str .. ""..items..":  "..amount.."\n"
    end
  end

    message:reply {
      embed = {
        title = "Inventory",
        author = {
          name = message.author.tag,
          icon_url = message.author.avatarURL
        },
        fields = {
          {
            name = "Currency",
            value = money_str,
            inline = false
          },
          {
            name = "Inventory",
            value = "You have used "..InvStatus(message).."/28 inventory slots.",
            inline = true
          }
        },
        footer = {
          text = "Items: \n"..inventory_str,
        },
        color = 0x34b7eb
      }
    }

end

function InvStatus(message)
  local data = LoadTable("accounts.json")
  local id = tostring(message.author.id)
  local items = 0
  for k, v in pairs(data[id]) do
   if k =='inventory' then
    for item, value in pairs(v) do
      items = items +value
     end
   end
  end
    return items
end

function HasSpace(message)
  local items = InvStatus(message)
  if items <= 27 then
    return true
  else
    return false
  end

end
function GetXP(id, skill)
  local data = LoadTable("accounts.json")
  for k, v in pairs(Skills) do
    if skill == v then
      return data[id]['statistics'][skill]
    end
  end
end

function RemoveSpam(id)
  for k, v in pairs(Spam) do
    if v == id then
      k = nil
    end
  end
end


function ItemSkill(message)
  local item_skill_types = { ['chop'] = true, ['mine'] = true, ['fish'] = true }
  local content = message.content
  local args = string.match(message.content, '^r%.(%S+)')
  local message_action = args
  local skill = action_to_skill[message_action]
  local hasSpace = HasSpace(message)
  if item_skill_types[message_action] == false then
    return false
  end
  if item_skill_types[message_action] == nil then
    return false
  end
  if hasSpace == false then
    Notify(message, 'inventory')
    return false
  end

  local skill_tools_table = skill_data[skill].tools
  local skill_rewards = skill_data[skill].item_rewards
  local currentXp = GetXP(message.author.id, skill)
  if item_skill_types[message_action] == true and hasSpace then
    table.insert(Spam, message.author.id)
    Notify(message, skill)
    local randomEquipTool = math.random(1, #skill_tools_table)
    local randomItem = math.random(1, #skill_rewards)
    local gainedItemAmount = RandomItemAmountForInventory(message)
    local equippedTool = skill_tools_table[randomEquipTool]
    local delay = math.random(equippedTool.delay[1], equippedTool.delay[2])+math.random(skill_rewards[randomItem].delay[1], skill_rewards[randomItem].delay[2])
    message:delete()
    
    if randomItem ~= 1 then
      print(randomItem)
      print((delay*gainedItemAmount) / 1000 .."s", message.author.tag)
      timer.sleep(delay*gainedItemAmount)
      local randomXp = math.random(375, 420)
      local currentLevel = XP2Level(currentXp + randomXp)
      randomXp = randomXp + skill_rewards[randomItem].xp
      CustomXP(message.author.id, skill, randomXp * gainedItemAmount / 2)
      AddItem(message.author.id, skill_rewards[randomItem].name, gainedItemAmount)

    message:reply {
      embed = {
        title = ""..FirstToUpper(skill),
        author = {
          name = message.author.tag,
          icon_url = message.author.avatarURL
        },
        fields = {
          {
            name = ""..skill_data[skill].icon.." **"..currentLevel.."/99** *("..Money_f(currentXp+randomXp).." xp)*",
            value = "You gained **"..(randomXp * gainedItemAmount) / 2 .."** experience from training "..skill..".",
            inline = true
          },
          {
            name = "Resource",
            value = ""..gainedItemAmount.." __"..skill_rewards[randomItem].name.."__ were gathered by using a "..skill_tools_table[randomEquipTool].name..".\n You have used **"..InvStatus(message).."/28** inventory spaces.",
            inline = false
          }
        },
        footer = {
          text = "This action took "..(delay*gainedItemAmount) / 1000 .." seconds."
        },
        color = tonumber(skill_rewards[randomItem].color)
      }
    }
  else
    local ndelay = math.random(3250, 5500)
    timer.sleep(ndelay)
        message:reply {
      embed = {
        title = ""..FirstToUpper(skill).."   "..skill_data[skill].icon.."",
        author = {
          name = message.author.tag,
          icon_url = message.author.avatarURL
        },
        footer = {
          text = "You were training for "..(ndelay / 1000).." seconds and found nothing."
        },
        color = 0x7f0000
      }
    }
  end
    
    table.remove(Spam, message.author.id)
    for k, v in pairs(Spam) do
      if v == message.author.id then
       table.remove(Spam, k)
      end
    end
  end
end

function ToolessSkill(message)

  local item_skill_types = { ['steal'] = true, ['bury'] = true, ['burn'] = true, ['build'] = true, ['farm'] = true, ['mix'] = true, ['run'] = true, ['cook'] = true, ['smith'] = true, ['runecraft'] = true, ['hunt'] = true, ['craft'] = true, ['fletch'] = true}
  local args = string.match(message.content, '^r%.(%S+)')
  local message_action = args
  local skill = action_to_skill[message_action]
  local hasSpace = HasSpace(message)
  local currentXp = GetXP(message.author.id, skill)
      if item_skill_types[message_action] == false then
    return false
  end
  if item_skill_types[message_action] == nil then
    return false
  end  
  local skill_rewards = skill_data[skill].item_rewards
  if item_skill_types[message_action] == true and hasSpace then
    table.insert(Spam, message.author.id)
    Notify(message, skill)
    local randomItem = math.random(1, #skill_rewards)
    local randomXp = math.random(420, 675)
    local currentLevel = XP2Level(currentXp + randomXp)
    local delay = math.random(skill_rewards[randomItem].delay[1], skill_rewards[randomItem].delay[2])
    
    message:delete()
    
    if randomItem ~= 1 then
      timer.sleep(delay)
      print((delay) / 1000 .."s", message.author.tag)
      randomXp = randomXp + skill_rewards[randomItem].xp
      CustomXP(message.author.id, skill, randomXp)
      if message_action ~= 'bury' or message_action ~= 'build' or message_action ~= 'burn' or message_action ~= 'farm' then
        AddItem(message.author.id, skill_rewards[randomItem].name, 1)
      end
    message:reply {
      embed = {
        title = ""..FirstToUpper(skill),
        author = {
          name = message.author.tag,
          icon_url = message.author.avatarURL 
        },
        fields = {
          {
            name = ""..skill_data[skill].icon.." **"..currentLevel.."/99** *("..currentXp+randomXp.." xp)*",
            value = "You gained **"..randomXp .."** experience from training "..skill..".",
            inline = true
          },
          {
            name = "Resource",
            value = ""..skill_rewards[randomItem].desc.."\n You have used **"..InvStatus(message).."/28** inventory spaces.",
            inline = false
          }
        },
        footer = {
          text = "This action took "..delay / 1000 .." seconds."
        },
        color = tonumber(skill_rewards[randomItem].color)
      }
    }
  else
    local ndelay = math.random(3250, 5500)
    timer.sleep(ndelay)
        message:reply {
      embed = {
        title = ""..FirstToUpper(skill).."   "..skill_data[skill].icon.."",
        author = {
          name = message.author.tag,
          icon_url = message.author.avatarURL
        },
        footer = {
          text = "You were training "..skill.." for "..(ndelay / 1000).." seconds and didn't complete the action."
        },
        color = 0x7f0000
      }
    }
  end
    
    table.remove(Spam, message.author.id)
    for k, v in pairs(Spam) do
      if v == message.author.id then
       table.remove(Spam, k)
      end
    end
  end
end

function RandomItemAmountForInventory(message)
  if InvStatus(message) <= 21 then
    return math.random(1, 7)
  end
  return 1
end

function SendHelp(message)
  message:reply {
    embed = {
      title = "⤤  Bot Creator",
      author = {
        name = "REDRUM#9269",
        icon_url = "https://cdn.discordapp.com/avatars/181447655434485760/8cb2a8b778255fc8a6a712560c7164f1.webp?size=128"
      },
      fields = {
        {
          name = [[<:info:785661687729487892> Commands]],
          value = [[<:info:785661687729487892> `r.register -- register your account to play`
          <:info:785661687729487892> `r.atkstyle -- set your attack style`
          <:info:785661687729487892> `⤷ r.atkstyle shared (shared, stab, crush, defensive, range & mage)`
          <:info:785661687729487892> `r.inventory -- shows your inventory`
          <:info:785661687729487892> `r.statistics -- shows your stats`
          <:info:785661687729487892> `r.sell -- sells all the items in your inventory`
          <:info:785661687729487892> `r.vote -- shows voting information`
          <:info:785661687729487892> `r.votestatus -- checks if you are eligible to vote`
          ]],
          inline = false
        },
        {
          name = [[<:skills:785715776141131776> Skill Commands]],
          value = [[<:Mining:784545971748601927> `r.mine` 
          <:Woodcutting:784545972386398248> `r.chop`
          <:Smithing:784545972415234048> `r.smith`
          <:Firemaking:784545972432535582> `r.burn`
          <:Thieving:784545971954384936> `r.steal`
          <:Agility:784545971991609364> `r.run`
          <:Fishing:784545972432404510> `r.fish`
          <:Cooking:784545972238680117> `r.cook`
          <:Farming:784545972432273418> `r.farm`
          <:Runecraft:784545972155711528> `r.runecraft`
          <:Construction:784545972390330378> `r.build`
          <:Prayer:784545972096335872> `r.bury`
          <:Crafting:784545971966312468> `r.craft`
          <:Fletching:784545972427554836> `r.fletch` 
          <:Hunter:784545972184285216> `r.hunt`
          <:Herblore:784545972063699004> `r.mix`]],
          inline = false
        },
        {
          name = "<:admin:785942586572800010> Admin Commands",
          value = [[<:admin:785942586572800010> `r.purge -- clears last 100 messages`]],
          inline = false
        }
      },
      footer = {
        text = ""
      },
      color = 0x2f3136
    }
  }
end

function SetStyle(id, style)
  local data = LoadTable("accounts.json")
  data[id]['attack_style'] = style
  SaveTable(data, "accounts.json")
end

function SetAtkStyle(message, style)
  local id = tostring(message.author.id)
  if style == 'shared' or style == 'stab' or style == 'crush' or style == 'defensive' or style == 'range' or style == 'magic' then
    SetStyle(id, style)
    message.channel:send(message.author.username..' your attack style was changed to '..style..'.')
  else
    Notify(message, "style-fail")
  end
end
function FlowerPoker(message, amount)
  local data = LoadTable("accounts.json")
  local balance = data[message.author.id]['currency']['Gold']
  if tonumber(balance) >= tonumber(amount) then
    local invite_code = string.gen(7)
    data[message.author.id]['currency']['Gold'] = tonumber(data[message.author.id]['currency']['Gold']) - tonumber(amount)
    SaveTable(data, "accounts.json")
    local invite = message:reply {
      embed = {
        title = "Gambling",
        author = {
          name = message.author.tag,
          icon_url = message.author.avatarURL
        },
        fields = {
          {name = "Game", value = "Flower Poker", inline = true},
          {name = "Amount", value = Money_f(tonumber(amount)), inline = true},
          {name = "Invite Code", value = invite_code, inline = true},
          {name = "Information", value = message.author.tag.." is trying to play flower poker for "..Money_f(tonumber(amount)).." gp. \nBe the first to type **`r.flowerpoker "..invite_code.."`**  to join this game.", inline = false},
        },
        footer = {
          text = "type 'r.host flower-poker [amount]' to host your own."
        },
        color = 0x6ffc03
      }
    }
    -- invite:addReaction("coins:785944586618536026") 
    -- print(invite.reactions:count())
    -- make sure to add check for already asigned invite codes.

      Flower_Poker[invite_code] = {
        ['host_id'] = message.author.id,
        ['host_name'] = message.author.tag,
        ['inv_msg'] = invite,
        ['pot'] = amount,
        ['instigator_id'] = "",
        ['instigator_msg'] = "",
        ['status'] = "waiting"
      }
  else
    message:reply {
      embed = {
        title = "Flower Poker",
        author = {
          name = message.author.tag,
          icon_url = message.author.avatarURL
        },
        footer = {
          text = message.author.tag.." is trying to play flower poker for "..Money_f(tonumber(amount)).." gp but can't afford it.."
        },
        color = 0xff0000
      }
    }
  end
end

function count(base, pattern)
  return select(2, string.gsub(base, pattern, ""))
end

function FPK_embed(instigator_id, instigator_value, host_id, host_name, host_roll, code, pot, invite_msg, instigator_msg, Flower_Rolled)
  invite_msg:reply {
    embed = {
      title = "Flower Poker ["..code.."]",
      author = {
        name = instigator_msg.author.tag,
        icon_url = instigator_msg.author.avatarURL
      },
      fields = {
        {name = instigator_msg.author.tag.." ("..flower_format(tonumber(instigator_value))..")", value = ""..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-1']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-2']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-3']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-4']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-5']['icon'].."", inline = true},
        {name = host_name.." ("..flower_format(tonumber(host_roll))..")", value = ""..Flower_Rolled[code][host_id]['flowers']['flower-1']['icon'].." ".. Flower_Rolled[code][host_id]['flowers']['flower-2']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-3']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-4']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-5']['icon'].."", inline = true},
      },
      footer = {
        text = instigator_msg.author.tag.." has won the flower poker match with "..flower_format(tonumber(instigator_value)).." and has received "..Money_f(tonumber(pot)).." gp."
      },
      color = 0x00ff00
    }
  }
  instigator_msg:reply {
    embed = {
      title = "Flower Poker ["..code.."]",
      author = {
        name = instigator_msg.author.tag,
        icon_url = instigator_msg.author.avatarURL
      },
      fields = {
        {name = instigator_msg.author.tag.." ("..flower_format(tonumber(instigator_value))..")", value = ""..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-1']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-2']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-3']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-4']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-5']['icon'].."", inline = true},
        {name = host_name.." ("..flower_format(tonumber(host_roll))..")", value = ""..Flower_Rolled[code][host_id]['flowers']['flower-1']['icon'].." ".. Flower_Rolled[code][host_id]['flowers']['flower-2']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-3']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-4']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-5']['icon'].."", inline = true},
      },
      footer = {
        text = instigator_msg.author.tag.." has won the flower poker match with "..flower_format(tonumber(instigator_value)).." and has received "..Money_f(tonumber(pot)).." gp."
      },
      color = 0x00ff00
    }
  }
end
function FPK_embed1(instigator_id, instigator_roll, host_id, host_name, host_roll, code, pot, invite_msg, instigator_msg, Flower_Rolled)
  invite_msg:reply {
    embed = {
      title = "Flower Poker ["..code.."]",
      author = {
        name = instigator_msg.author.tag,
        icon_url = instigator_msg.author.avatarURL
      },
      fields = {
        {name = instigator_msg.author.tag.." ("..flower_format(tonumber(instigator_roll))..")", value = ""..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-1']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-2']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-3']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-4']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-5']['icon'].."", inline = true},
        {name = host_name.." ("..flower_format(tonumber(host_roll))..")", value = ""..Flower_Rolled[code][host_id]['flowers']['flower-1']['icon'].." ".. Flower_Rolled[code][host_id]['flowers']['flower-2']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-3']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-4']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-5']['icon'].."", inline = true},
      },
      footer = {
        text = "Both players tied with "..flower_format(tonumber(instigator_roll)).." and have been refunded "..Money_f(tonumber(pot)).." gp."
      },
      color = 0xff0000
    }
  }
  instigator_msg:reply {
    embed = {
      title = "Flower Poker ["..code.."]",
      author = {
        name = instigator_msg.author.tag,
        icon_url = instigator_msg.author.avatarURL
      },
      fields = {
        {name = instigator_msg.author.tag.." ("..flower_format(tonumber(instigator_roll))..")", value = ""..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-1']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-2']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-3']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-4']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-5']['icon'].."", inline = true},
        {name = host_name.." ("..flower_format(tonumber(host_roll))..")", value = ""..Flower_Rolled[code][host_id]['flowers']['flower-1']['icon'].." ".. Flower_Rolled[code][host_id]['flowers']['flower-2']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-3']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-4']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-5']['icon'].."", inline = true},
      },
      footer = {
        text = "Both players tied with "..flower_format(tonumber(instigator_roll)).." and have been refunded "..Money_f(tonumber(pot)).." gp."
      },
      color = 0xff0000
    }
  }
end
function FPK_embed2(host_id, host_name, host_value, instigator_id, instigator_roll, code, pot, invite_msg, instigator_msg, Flower_Rolled)
  invite_msg:reply {
    embed = {
      title = "Flower Poker ["..code.."]",
      author = {
        name = host_name,
        icon_url = invite_msg.author.avatarURL
      },
      fields = {
        {name = instigator_msg.author.tag.." ("..flower_format(tonumber(instigator_roll))..")", value = ""..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-1']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-2']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-3']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-4']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-5']['icon'].."", inline = true},
        {name = host_name.." ("..flower_format(tonumber(host_value))..")", value = ""..Flower_Rolled[code][host_id]['flowers']['flower-1']['icon'].." ".. Flower_Rolled[code][host_id]['flowers']['flower-2']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-3']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-4']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-5']['icon'].."", inline = true},
      },
      footer = {
        text = host_name.." has won the flower poker match with "..flower_format(tonumber(host_value)).." and has received "..Money_f(tonumber(pot)).." gp."
      },
      color = 0x00ff00
    }
  }
  instigator_msg:reply {
    embed = {
      title = "Flower Poker ["..code.."]",
      author = {
        name = host_name,
        icon_url = invite_msg.author.avatarURL
      },
      fields = {
        {name = instigator_msg.author.tag.." ("..flower_format(tonumber(instigator_roll))..")", value = ""..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-1']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-2']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-3']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-4']['icon'].." "..Flower_Rolled[code][instigator_msg.author.id]['flowers']['flower-5']['icon'].."", inline = true},
        {name = host_name.." ("..flower_format(tonumber(host_value))..")", value = ""..Flower_Rolled[code][host_id]['flowers']['flower-1']['icon'].." ".. Flower_Rolled[code][host_id]['flowers']['flower-2']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-3']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-4']['icon'] .." "..Flower_Rolled[code][host_id]['flowers']['flower-5']['icon'].."", inline = true},
      },
      footer = {
        text = host_name.." has won the flower poker match with "..flower_format(tonumber(host_value)).." and has received "..Money_f(tonumber(pot)).." gp."
      },
      color = 0x00ff00
    }
  }
end
function FPK_Calc(inv_code, host_id, host_name, instigator_id, Rolls)
  local flower1,flower2,flower3,flower4,flower5 = 0,0,0,0,0
  local flower11,flower22,flower33,flower44,flower55 = 0,0,0,0,0
  local host_roll, instigator_roll = 0,0
  for k, v in pairs(Rolls[inv_code][host_id]['flowers']) do

      if Rolls[inv_code][host_id]['flowers'][k]['id'] == Rolls[inv_code][host_id]['flowers']['flower-1']['id'] then 
        flower1 = flower1 + 1
      end
      if Rolls[inv_code][host_id]['flowers'][k]['id'] == Rolls[inv_code][host_id]['flowers']['flower-2']['id'] then 
        flower2 = flower2 + 1
      end
      if Rolls[inv_code][host_id]['flowers'][k]['id'] == Rolls[inv_code][host_id]['flowers']['flower-3']['id'] then 
        flower3 = flower3 + 1
      end
      if Rolls[inv_code][host_id]['flowers'][k]['id'] == Rolls[inv_code][host_id]['flowers']['flower-4']['id'] then 
        flower4 = flower4 + 1
      end
      if Rolls[inv_code][host_id]['flowers'][k]['id'] == Rolls[inv_code][host_id]['flowers']['flower-5']['id'] then 
        flower5 = flower5 + 1
      end
  end
  for c, x in pairs(Rolls[inv_code][instigator_id]['flowers']) do

    if Rolls[inv_code][instigator_id]['flowers'][c]['id'] == Rolls[inv_code][instigator_id]['flowers']['flower-1']['id'] then 
      flower11 = flower11 + 1
    end
    if Rolls[inv_code][instigator_id]['flowers'][c]['id'] == Rolls[inv_code][instigator_id]['flowers']['flower-2']['id'] then 
      flower22 = flower22 + 1
    end
    if Rolls[inv_code][instigator_id]['flowers'][c]['id'] == Rolls[inv_code][instigator_id]['flowers']['flower-3']['id'] then 
      flower33 = flower33 + 1
    end
    if Rolls[inv_code][instigator_id]['flowers'][c]['id'] == Rolls[inv_code][instigator_id]['flowers']['flower-4']['id'] then 
      flower44 = flower44 + 1
    end
    if Rolls[inv_code][instigator_id]['flowers'][c]['id'] == Rolls[inv_code][instigator_id]['flowers']['flower-5']['id'] then 
      flower55 = flower55 + 1
    end
end
host_roll = tonumber(flower1)+tonumber(flower2)+tonumber(flower3)+tonumber(flower4)+tonumber(flower5)
instigator_roll = tonumber(flower11)+tonumber(flower22)+tonumber(flower33)+tonumber(flower44)+tonumber(flower55)

  if tonumber(instigator_roll) > tonumber(host_roll) then
  print("instigator won with a ", flower_format(instigator_roll))
  AddGold(instigator_id, Flower_Poker[inv_code]['pot']*2)
  FPK_embed(instigator_id, instigator_roll, host_id, host_name, host_roll, inv_code, Flower_Poker[inv_code]['pot']*2, Flower_Poker[inv_code]['inv_msg'], Flower_Poker[inv_code]['instigator_msg'], Rolls)
  Flower_Poker[inv_code] = nil
  end

  if tonumber(instigator_roll) == tonumber(host_roll) then
    print("Both players Tied with, ", flower_format(instigator_roll))
    AddGold(host_id, Flower_Poker[inv_code]['pot'])
    AddGold(instigator_id, Flower_Poker[inv_code]['pot'])
    FPK_embed1(instigator_id, instigator_roll, host_id, host_name, host_roll, inv_code, Flower_Poker[inv_code]['pot']*2, Flower_Poker[inv_code]['inv_msg'], Flower_Poker[inv_code]['instigator_msg'], Rolls)
    Flower_Poker[inv_code] = nil
  end

  if tonumber(host_roll) > tonumber(instigator_roll) then
    print("host won with a ", flower_format(host_roll))
    AddGold(host_id, Flower_Poker[inv_code]['pot']*2)
    FPK_embed2(host_id, host_name, host_roll, instigator_id, instigator_roll, inv_code, Flower_Poker[inv_code]['pot']*2, Flower_Poker[inv_code]['inv_msg'], Flower_Poker[inv_code]['instigator_msg'], Rolls)
    Flower_Poker[inv_code] = nil
  end

end
client:on('messageCreate', function(message)
  local data = LoadTable("accounts.json")
  local registered = IsRegistered(message)
  local id = tostring(message.author.id)
  local imune = "780896702495588352"
  local content = message.content
  local args = content:split(" ")
  local isPlaying = false
  
  if message.author.bot == true then
    return false
  end
  
  if args[1] == 'r.atkstyle' then
    if args[2] ~= nil then
      message:delete()
      SetAtkStyle(message, args[2])
    else
      Notify(message, "style-fail")
    end
  end

  if args[1] == 'r.sell' then
    message:delete()
    Sell(message.author.id, message)
  end

  if args[1] == 'r.statistics' or args[1] == 'r.stats' then
    message:delete()
    Statistics(message)
  end

  if args[1] == 'r.inventory' or args[1] == 'r.inv' then
    message:delete()
    Inventory(message)
  end

  if args[1] == 'r.host' then
    if args[2] == nil then
      print("no 2nd arg supplied")
      return false
    end
    if args[3] == nil then
      print("no 3rd arg supplied")
      return false
    end
    if type(tonumber(args[3])) == 'string' then
        print("expected number for host command.")
      return false
    end

    if args[2] == 'flower-poker' or args[2] == 'fp' then
      local int = args[3]:gsub("%D+", "")
      if tonumber(int) >= 0 or int ~= nil then
        FlowerPoker(message, int)
        message:delete()
      end
    end
  end
  
  if args[1] == 'r.flowerpoker' or args [1] == 'r.fp' then
    if args[2] == nil then
      print("no 2nd argument was provided.")
      return false
    end
    
    local  inv_code, host_id, host_name, inv_msg, pot, instigator_id, instigator_msg, status = Flower_code_Lookup(args[2])
    local instigator_balance = data[message.author.id]['currency']['Gold']

    if host_id == nil then
      print("host_id == nil")
      return false
    end

    if host_id == message.author.id then
      print("host_id == message.author.id")
      return false
    end
    if tonumber(instigator_balance) >= tonumber(pot) then
      instigator_balance = instigator_balance - pot
      SaveTable(data, "accounts.json")
      if inv_code == args[2] then
        Flower_Poker[inv_code] = {
          ['host_id'] = host_id,
          ['host_name'] = Flower_Poker[inv_code]['host_name'],
          ['inv_msg'] = Flower_Poker[inv_code]['inv_msg'],
          ['pot'] = Flower_Poker[inv_code]['pot'],
          ['instigator_id'] = message.author.id,
          ['instigator_msg'] = message,
          ['status'] = 'ready'
        }
        inv_code, host_id, host_name, inv_msg, pot, instigator_id, instigator_msg = Flower_code_Lookup(args[2])
      end
      local h1,h2,h3,h4,h5 = math.random(1, 8), math.random(1, 8), math.random(1, 8), math.random(1, 8), math.random(1, 8)
      local i1,i2,i3,i4,i5 = math.random(1, 8), math.random(1, 8), math.random(1, 8), math.random(1, 8), math.random(1, 8)
      Flower_Rolls[inv_code] = {
        [host_id] = {
          ['flowers'] = {
            ['flower-1'] = {
              ['name'] = Flowers[h1],
              ['id'] = h1,
              ['icon'] = Flowers[h1]['icon']
            },
            ['flower-2'] = {
              ['name'] = Flowers[h2],
              ['id'] = h2,
              ['icon'] = Flowers[h2]['icon']
            },
            ['flower-3'] = {
              ['name'] = Flowers[h3],
              ['id'] = h3,
              ['icon'] = Flowers[h3]['icon']
            },
            ['flower-4'] = {
              ['name'] = Flowers[h4],
              ['id'] = h4,
              ['icon'] = Flowers[h4]['icon']
            },
            ['flower-5'] = {
              ['name'] = Flowers[h5],
              ['id'] = h5,
              ['icon'] = Flowers[h5]['icon']
            },
          },
        },
        [instigator_id] = {
          ['flowers'] = {
            ['flower-1'] = {
              ['name'] = Flowers[i1],
              ['id'] = i1,
              ['icon'] = Flowers[i1]['icon']
            },
            ['flower-2'] = {
              ['name'] = Flowers[i2],
              ['id'] = i2,
              ['icon'] = Flowers[i2]['icon']
            },
            ['flower-3'] = {
              ['name'] = Flowers[i3],
              ['id'] = i3,
              ['icon'] = Flowers[i3]['icon']
            },
            ['flower-4'] = {
              ['name'] = Flowers[i4],
              ['id'] = i4,
              ['icon'] = Flowers[i4]['icon']
            },
            ['flower-5'] = {
              ['name'] = Flowers[i5],
              ['id'] = i5,
              ['icon'] = Flowers[i5]['icon']
            },
          },
        }
      }
      FPK_Calc(inv_code, host_id, host_name, instigator_id, Flower_Rolls)
    end
  end

  if args[1] == 'r.votestatus' then
    message:delete()
    CheckVote(message, message.author.id)
  end

  if args[1] == 'r.vote' then
    message:delete()
    Vote(message, message.author.id)
  end

  if args[1] == 'r.register' then
    message:delete()
    Register(message)
  end

  if args[1] == 'r.help' then
    message:delete()
    SendHelp(message)
  end

  for a, b in pairs (Spam) do
        if b == id then
          isPlaying = true
        end
    end
  
    if isPlaying == true then
      return false
    end

  if args[1] ~= 'r.register' and registered == false then
    message:delete()
    Register(message)
    return false
  end


  -- admin --

  if args[1] == 'r.purge' then
   local isStaff = message.member:hasPermission("administrator")
   if isStaff == true then
    MG = message.channel:getMessages(100)
    message.channel:bulkDelete(MG)
   else
    Notify(message, 'staff')
   end
  end

  if  registered == true then
  -- skills --
    ItemSkill(message)
    ToolessSkill(message)
    AddXp(id, data[id]['attack_style'])
  end
end)

function VoteHandler(id, double, site)
  local channel = "786436743011500082"
  local member = client:getUser(id)
  local points = 0

  if double == true then
    points = 2
  else
    points = 1
  end
  AddVotes(id, points)
  if site == 'topgg' then
    site = "Top.gg"
  elseif site == 'dbl' then
    site = "Discordbotlist.com"
  end
 
  channel = client:getChannel(channel)
  channel:send {
    embed = {
      title = "Has voted on "..site,
      author = {
        name = member.tag,
        icon_url = member.avatarURL
      },
      fields = {
        {name = "<:voter:788229347701817364>  "..member.username.." received "..points.." vote point.", value = "Type r.vote to vote for Runescape bot.", inline = false}
      },
      color = 0x2f3136,
      timestamp = discordia.Date():toISO('T', 'Z')
    }
  }
end
app:use(http.createServer(function (req, res)

  req:on('data', coroutine.wrap(function(data)
    local tbl = json.decode(data)
    local topgg_secret = "sdasdasdasdas"
      for k, v in pairs(req.headers) do
          if v[1] == 'Authorization' and v[2] == topgg_secret then
            print("Top.gg vote received for ("..tbl['user']..")")
            VoteHandler(tbl['user'], tbl['isWeekend'], "topgg")
          end
      end
  end))
	res.statusCode = 200
  res.statusMessage = ""
	res:setHeader("Content-Length", 0)
	res:finish('you posted: ' .. json.stringify(req.body, {indent = 2}))
end):listen(43594, "0.0.0.0"))

app:use(https.createServer({
  key = fs.readFileSync("/home/privkey.pem"),
  cert = fs.readFileSync("/home/cert.pem")
}, 

function(req, res)
  req:on('data', coroutine.wrap(function(data)
    local tbl = json.decode(data)
    local dblsecret = "sssss"

      for k, v in pairs(req.headers) do
          if v[1] == 'Authorization' and v[2] == dblsecret then
            print("DBL vote received for ("..tbl['username'].."#"..tbl['discriminator']..")")
            VoteHandler(tbl['id'], false, "dbl")
          end
      end
  end)
)
	res.statusCode = 200
  res.statusMessage = ""
  res:setHeader("Content-Length", 0)
  res:setHeader('Access-Control-Allow-Headers', '*')
  res:setHeader('Access-Control-Allow-Origin', '*')
	res:setHeader('Access-Control-Request-Method', '*')
	res:finish('you posted: ' .. json.stringify(req.body, {indent = 2}))
end):listen(7777))
print("Server listening at https://localhost:7777/")

client:run('Bot '..token)