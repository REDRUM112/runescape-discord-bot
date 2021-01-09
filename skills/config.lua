return {
  ['skill_data'] = {
    ['woodcutting'] = {
      ['icon'] = "<:Woodcutting:784545972386398248>",
      ['tools'] = {
        { 
          ['name'] = 'Mithril Axe',
            ['delay'] = { 1000, 2500}
          },
          { 
            ['name'] = 'Rune Axe', 
            ['delay'] = { 500, 1000}
          },
          { 
            ['name'] = 'Dragon Axe',
            ['delay'] = { 0, 200}
          }
        },
        ['item_rewards'] = {
          {
            ['name'] = 'None',
            ['delay'] = { 0, 1 },
            ['xp'] = 1,
            ['color'] = '0xff0000'
          },
          {
            ['name'] = 'Willow Log',
            ['delay'] = { 250, 500 },
            ['xp'] = 25,
            ['color'] = '0x586640'
          },
          {
            ['name'] = 'Yew Log',
            ['delay'] = { 500, 1000 },
            ['xp'] = 50,
            ['color'] = '0x523a04'
          },
          {
            ['name'] = 'Magic Log',
            ['delay'] = { 1650, 3250 },
            ['xp'] = 75,
            ['color'] = '0x14a3a6'
          },
        }
      },
      ['fishing'] = {
        ['icon'] = "<:Fishing:784545972432404510>",
        ['tools'] = {
          { 
            ['name'] = 'Net',
              ['delay'] = { 1000, 2500}
            },
            { 
              ['name'] = 'Lobster Cage',
              ['delay'] = { 500, 1000}
            },
            { 
              ['name'] = 'Harpoon',
              ['delay'] = { 0, 200}
            }
          },
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['delay'] = { 0, 1 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Raw Shrimp',
              ['delay'] = { 250, 500 },
              ['xp'] = 25,
              ['color'] = 'aa9388'
            },
            {
              ['name'] = 'Raw Lobster',
              ['delay'] = { 500, 1000 },
              ['xp'] = 50,
              ['color'] = '0x73421d'
            },
            {
              ['name'] = 'Raw Shark',
              ['delay'] = { 1650, 3250 },
              ['xp'] = 75,
              ['color'] = '0x766e6d'
            },
          }
        },
      ['mining'] = {
        ['icon'] = "<:Mining:784545971748601927>",
        ['tools'] = {
          { 
            ['name'] = 'Bronze Pickaxe',
            ['delay'] = { 1000, 2500}
          },
          { 
            ['name'] = 'Rune Pickaxe', 
            ['delay'] = { 500, 1000}
          },
          { 
            ['name'] = 'Dragon Pickaxe',
            ['delay'] = { 0, 200}
          }
        },
        ['item_rewards'] = {
          {
            ['name'] = 'None',
            ['delay'] = { 0, 1 },
            ['xp'] = 1,
            ['color'] = '0xff0000'
          },
          {
            ['name'] = 'Copper Ore',
            ['delay'] = { 250, 500 },
            ['xp'] = 25,
            ['color'] = '0xa66208'
          },
          {
            ['name'] = 'Coal Ore',
            ['delay'] = { 500, 1000 },
            ['xp'] = 50,
            ['color'] = '0x393724'
          },
          {
            ['name'] = 'Runite Ore',
            ['delay'] = { 1650, 3250 },
            ['xp'] = 75,
            ['color'] = '0x496b76'
          },
        }
      },
      ['herblore'] = {
        ['icon'] = "<:Herblore:784545972063699004>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Attack Potion',
              ['desc'] = '1 __Attack Potion__ was made by mixing an eye of newt, guam weed and water',
              ['delay'] = { 750, 1250 },
              ['xp'] = 25,
              ['color'] = '0x75ebec'
            },
            {
              ['name'] = 'Prayer Potion',
              ['desc'] = '1 __Prayer Potion__ was made by mixing Snape grass, ranarr weed and water.',
              ['delay'] = { 1250, 1650 },
              ['xp'] = 50,
              ['color'] = '0x7df0c3'
            },
            {
              ['name'] = 'Anti-Venom+',
              ['desc'] = '1 __Anti-Venom+__ was made by mixing Anti-venom(4) & Torstol.',
              ['delay'] = { 1650, 3250 },
              ['xp'] = 75,
              ['color'] = '0x766265'
            },
          }
        },
      ['thieving'] = {
        ['icon'] = "<:Thieving:784545971954384936>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Cup Of Tea',
              ['desc'] = '1 __Cup Of Tea__ was gathered from stealing from the tea stall.',
              ['delay'] = { 950, 1500 },
              ['xp'] = 55,
              ['color'] = '0x80670d'
            },
            {
              ['name'] = 'Strawberry Seed',
              ['desc'] = '1 __Strawberry Seed__ was gathered from stealing from the seed stall.',
              ['delay'] = { 950, 1500 },
              ['xp'] = 85,
              ['color'] = '0xa7935e'
            },
            {
              ['name'] = 'Diamond',
              ['desc'] = '1 __Diamond__ was gathered from stealing from the gem stall.',
              ['delay'] = { 950, 1500 },
              ['xp'] = 145,
              ['color'] = '0xe2ddd7'
            },
          }
        },
      ['agility'] = {
        ['icon'] = "<:Agility:784545971991609364>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Mark Of Grace',
              ['desc'] = '1 __Mark Of Grace__ was found from doing the Draynor Village Rooftop Course.',
              ['delay'] = { 750, 775 },
              ['xp'] = 25,
              ['color'] = '0x80670d'
            },
            {
              ['name'] = 'Mark Of Grace',
              ['desc'] = '1 __Mark Of Grace__ was found from doing the Canifis Rooftop Course.',
              ['delay'] = { 885, 900 },
              ['xp'] = 50,
              ['color'] = '0xa7935e'
            },
            {
              ['name'] = 'Mark Of Grace',
              ['desc'] = '1 __Mark Of Grace__ was found from doing the Ardougne Rooftop Course.',
              ['delay'] = { 2275, 2295 },
              ['xp'] = 75,
              ['color'] = '0xe2ddd7'
            },
          }
        },
      ['runecrafting'] = {
        ['icon'] = "<:Runecraft:784545972155711528>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Air Runes',
              ['desc'] = '1 __Air Runes__ was made at the Air altar.',
              ['delay'] = { 1350, 1850 },
              ['xp'] = 25,
              ['color'] = '0xe4e1e1'
            },
            {
              ['name'] = 'Nature Runes',
              ['desc'] = '1 __Nature Runes__ was made at the Nature altar.',
              ['delay'] = { 1350, 1850 },
              ['xp'] = 50,
              ['color'] = '0x118b15'
            },
            {
              ['name'] = 'Blood Runes',
              ['desc'] = '1 __Blood Runes__ was made at the Blood altar.',
              ['delay'] = { 1350, 1850 },
              ['xp'] = 75,
              ['color'] = '0x8b1d11'
            },
          }
        },
      ['hunter'] = {
        ['icon'] = "<:Hunter:784545972184285216>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Baby Impling Jar',
              ['desc'] = '1 __Baby Impling Jar__ was found and was put in a jar.',
              ['delay'] = { 420, 700 },
              ['xp'] = 25,
              ['color'] = '0x886c87'
            },
            {
              ['name'] = 'Dragon Impling Jar',
              ['desc'] = '1 __Dragon Impling Jar__ was found and was put in a jar.',
              ['delay'] = { 800, 1200 },
              ['xp'] = 50,
              ['color'] = '0xfb8a31'
            },
            {
              ['name'] = 'Lucky Impling Jar',
              ['desc'] = '1 __Lucky Impling Jar__ was found and was put in a jar.',
              ['delay'] = { 1450, 2250 },
              ['xp'] = 75,
              ['color'] = '08e113f'
            },
          }
        },
      ['cooking'] = {
        ['icon'] = "<:Cooking:784545972238680117>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Tuna',
              ['desc'] = '1 __Tuna__ was cooked.',
              ['delay'] = { 250, 500 },
              ['xp'] = 25,
              ['color'] = '0xac8e89'
            },
            {
              ['name'] = 'Swordfish',
              ['desc'] = '1 __Swordfish__ was cooked.',
              ['delay'] = { 500, 1000 },
              ['xp'] = 50,
              ['color'] = '0xab67b6'
            },
            {
              ['name'] = 'Manta Ray',
              ['desc'] = '1 __Manta Ray__ was cooked.',
              ['delay'] = { 1150, 1650 },
              ['xp'] = 75,
              ['color'] = '0x8a6a4e'
            },
          }
        },     
      ['crafting'] = {
        ['icon'] = "<:Crafting:784545971966312468>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Leather Gloves',
              ['desc'] = '1 __Leather Gloves__ was made by threading a piece of leather.',
              ['delay'] = { 625, 1000 },
              ['xp'] = 25,
              ['color'] = '0x575215'
            },
            {
              ['name'] = 'Snakeskin Bandana',
              ['desc'] = '1 __Snakeskin Bandana__ was made by threading a piece of snakeskin.',
              ['delay'] = { 1200, 1845 },
              ['xp'] = 50,
              ['color'] = '0xa7935e'
            },
            {
              ['name'] = 'Black Dragonhide Body',
              ['desc'] = '1 __Mark Of Grace__ was made by threading a piece of black dragonhide.',
              ['delay'] = { 1650, 2450 },
              ['xp'] = 75,
              ['color'] = '0xe2ddd7'
            },
          }
        },
      ['fletching'] = {
        ['icon'] = "<:Fletching:784545972427554836>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Arrow Shaft',
              ['desc'] = '1 __Arrow Shaft__ was made using a knife.',
              ['delay'] = { 500, 800 },
              ['xp'] = 25,
              ['color'] = '0x543208'
            },
            {
              ['name'] = 'Mithril Arrow',
              ['desc'] = '1 __Mithril Arrow__ was made by attaching a mithril arrow head to an arrow sharft.',
              ['delay'] = { 1250, 1650 },
              ['xp'] = 50,
              ['color'] = '0x424262'
            },
            {
              ['name'] = 'Magic Shortbow',
              ['desc'] = '1 __Magic Shortbow__ was made by stringing a magic shortbow (u).',
              ['delay'] = { 1450, 2150 },
              ['xp'] = 75,
              ['color'] = '0x005f55'
            },
          }
        },
      ['smithing'] = {
        ['icon'] = "<:Smithing:784545972415234048>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 0,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Bronze Bar',
              ['desc'] = '1 __Bronze Bar__ was smelted using a Tin Ore and a Copper Ore',
              ['delay'] = { 475, 925 },
              ['xp'] = 25,
              ['color'] = '0x60492c'
            },
            {
              ['name'] = 'Gold Bar',
              ['desc'] = '1 __Gold Bar__ was smelted using a Coal Ore and a Gold Ore',
              ['delay'] = { 950, 1300 },
              ['xp'] = 50,
              ['color'] = '0xb19014'
            },
            {
              ['name'] = 'Rune Bar',
              ['desc'] = '1 __Rune Bar__ was smelted using a Coal Ore and a Runite Ore',
              ['delay'] = { 1420, 2250 },
              ['xp'] = 75,
              ['color'] = '0x496b76'
            },
          }
        },
      ['construction'] = {
        ['icon'] = "<:Construction:784545972390330378>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Varrock Portal',
              ['desc'] = '1 __Varrock Portal__ was directed using 300 Air runes, 100 Fire runes and 100 Law runes',
              ['delay'] = { 850, 1250 },
              ['xp'] = 25,
              ['color'] = '0xf2b35a'
            },
            {
              ['name'] = 'Falador Portal',
              ['desc'] = '1 __Falador Portal__ was directed using 300 Air runes, 100 Water runes and 100 Law runes',
              ['delay'] = { 1150, 1850 },
              ['xp'] = 50,
              ['color'] = '0x882ebb'
            },
            {
              ['name'] = 'Catherby Portal',
              ['desc'] = '1 __Catherby Portal__ was directed using 1000 Water runes, 300 Astral runes and 300 Law runes',
              ['delay'] = { 1750, 2650 },
              ['xp'] = 75,
              ['color'] = '0xe2d289'
            },
          }
        },
      ['prayer'] = {
        ['icon'] = "<:Prayer:784545972096335872>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Dragon Bone',
              ['desc'] = '1 __Dragon Bone__ was burried',
              ['delay'] = { 850, 1350 },
              ['xp'] = 120,
              ['color'] = '0xc6bdbd'
            },
            {
              ['name'] = 'Ourg Bone',
              ['desc'] = '1 __Ourg Bone__ was burried',
              ['delay'] = { 850, 1350 },
              ['xp'] = 175,
              ['color'] = '0x849a10'
            },
            {
              ['name'] = 'Superior Dragon Bone',
              ['desc'] = '1 __Superior Dragon Bone__ was burried',
              ['delay'] = { 850, 1350 },
              ['xp'] = 335,
              ['color'] = '0x6fc3b9'
            },
          }
        },
      ['firemaking'] = {
        ['icon'] = "<:Firemaking:784545972432535582>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Willow log',
              ['desc'] = '1 __Willow log__ was burned',
              ['delay'] = { 850, 1350 },
              ['xp'] = 110,
              ['color'] = '0x586640'
            },
            {
              ['name'] = 'Yew log',
              ['desc'] = '1 __Yew log__ was burned',
              ['delay'] = { 850, 1350 },
              ['xp'] = 155,
              ['color'] = '0x523a04'
            },
            {
              ['name'] = 'Magic log',
              ['desc'] = '1 __Magic log__ was burned',
              ['delay'] = { 850, 1350 },
              ['xp'] = 275,
              ['color'] = '0x14a3a6'
            },
          }
        },
      ['farming'] = {
        ['icon'] = "<:Farming:784545972432273418>",
          ['item_rewards'] = {
            {
              ['name'] = 'None',
              ['desc'] = '',
              ['delay'] = { 1, 2 },
              ['xp'] = 1,
              ['color'] = '0xff0000'
            },
            {
              ['name'] = 'Acorn Seed',
              ['desc'] = '1 __Acorn Seed__ was planted',
              ['delay'] = { 850, 1350 },
              ['xp'] = 135,
              ['color'] = '0x7d8930'
            },
            {
              ['name'] = 'Snapdragon Seed',
              ['desc'] = '1 __Snapdragon Seed__ was planted',
              ['delay'] = { 850, 1350 },
              ['xp'] = 250,
              ['color'] = '0x416b00'
            },
            {
              ['name'] = 'Redwood Tree Seed',
              ['desc'] = '1 __Redwood Tree Seed__ was planted',
              ['delay'] = { 850, 1350 },
              ['xp'] = 475,
              ['color'] = '0xac6e61'
            },
          }
        }
      },      
    ['action_to_skill'] = {
      -- item skill 3
      ['mine'] = 'mining',
      ['chop'] = 'woodcutting',
      ['fish'] = 'fishing',
      -- toolesskill 9
      ['steal'] = 'thieving',
      ['mix'] = 'herblore',
      ['run'] = 'agility',
      ['runecraft'] = 'runecrafting',
      ['hunt'] = 'hunter',
      ['cook'] = 'cooking',
      ['craft'] = 'crafting',
      ['fletch'] = 'fletching',
      ['smith'] = 'smithing',
      -- no reward skill 4
      ['build'] = 'construction',
      ['bury'] = 'prayer',
      ['farm'] = 'farming',
      ['burn'] = 'firemaking'
    }
  }