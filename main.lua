--- STEAMODDED HEADER
--- MOD_NAME: Tasty Mod
--- MOD_ID: TastyMod
--- MOD_AUTHOR: Tasty
--- MOD_DESCRIPTION: WHAT?


SMODS.Atlas {
  key = "tm_jokers",
  path = "joker.png",
  px = 71,
  py = 95,
}

-- Jokers
SMODS.load_file("jokers/send_the_poor.lua")()
SMODS.load_file("jokers/jack_the_ripper.lua")()
SMODS.load_file("jokers/bloodlust.lua")()
SMODS.load_file("jokers/tasty_donut.lua")()
SMODS.load_file("jokers/medusa.lua")()
SMODS.load_file("jokers/rock_hard.lua")()
SMODS.load_file("jokers/la_pasion.lua")()
SMODS.load_file("jokers/his_majesty.lua")()
SMODS.load_file("jokers/snowball.lua")()
SMODS.load_file("jokers/rearguard.lua")()
SMODS.load_file("jokers/bleed_from_within.lua")()
SMODS.load_file("jokers/beer.lua")()
SMODS.load_file("jokers/alcoholic.lua")()
SMODS.load_file("jokers/grey.lua")()
SMODS.load_file("jokers/void_cat.lua")()


-- Spectral Cards
SMODS.load_file("consumables/gluttony.lua")()
SMODS.load_file("consumables/glory.lua")()
SMODS.load_file("consumables/summon_forth.lua")()
SMODS.load_file("consumables/dying_star.lua")()


-- Seals
SMODS.load_file("seals/grey_seal.lua")()
SMODS.load_file("seals/orange_seal.lua")()
SMODS.load_file("seals/void_seal.lua")()

local game_start_run_ref = Game.start_run
function Game:start_run(args)
  game_start_run_ref(self, args)
  G.E_MANAGER:add_event(Event({
    func = function()
      add_joker('j_tm_jack_the_ripper')
      add_joker('j_tm_bloodlust')
      add_joker('j_tm_void_cat')
      local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_tm_dying_star')
      card:add_to_deck()
      G.consumeables:emplace(card)
      local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_tm_dying_star')
      card:add_to_deck()
      G.consumeables:emplace(card)
      local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_tm_dying_star')
      card:add_to_deck()
      G.consumeables:emplace(card)
      local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_tm_dying_star')
      card:add_to_deck()
      G.consumeables:emplace(card)
      local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_tm_dying_star')
      card:add_to_deck()
      G.consumeables:emplace(card)
      local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_tm_dying_star')
      card:add_to_deck()
      G.consumeables:emplace(card)
      return true
    end
  }))
end

-- Track destroyed cards for Bloodlust
local game_init_game_object_ref = Game.init_game_object
function Game:init_game_object()
  local g = game_init_game_object_ref(self)
  g.tm_cards_destroyed = 0
  return g
end

local card_remove_ref = Card.remove
function Card:remove()
  if self.added_to_deck and self.ability and self.ability.set == 'Default' or self.ability and self.ability.set == 'Enhanced' then
    if G.GAME and G.GAME.tm_cards_destroyed then
      G.GAME.tm_cards_destroyed = G.GAME.tm_cards_destroyed + 1
    end
  end
  card_remove_ref(self)
end

