--- STEAMODDED HEADER
--- MOD_NAME: Tasty Mod
--- MOD_ID: TastyMod
--- MOD_AUTHOR: Tasty
--- MOD_DESCRIPTION: WHAT?


SMODS.Atlas {
  key = "tm_jokers",
  path = "jokers.png",
  px = 71,
  py = 95,
}

-- Jokers
SMODS.load_file("jokers/send_the_poor.lua")()
SMODS.load_file("jokers/jack_the_ripper.lua")()
SMODS.load_file("jokers/bloodlust.lua")()
SMODS.load_file("jokers/tasty_donut.lua")()
SMODS.load_file("jokers/time_alter.lua")()
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
      add_joker('j_tm_tasty_donut')
      add_joker('j_tm_his_majesty')
      add_joker('j_tm_grey')
      local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, 'c_tm_dying_star')
      card:add_to_deck()
      G.consumeables:emplace(card)
      return true
    end
  }))
end

local play_cards_ref = G.FUNCS.play_cards_from_highlighted
-- Timer Alter joker test
G.FUNCS.play_cards_from_highlighted = function(e)
  if next(SMODS.find_card('j_tm_time_alter')) then
    local cards_to_draw = #G.hand.highlighted

    play_cards_ref(e)

    G.E_MANAGER:add_event(Event({
      trigger = 'before',
      delay = 0.1,
      func = function()
        G.FUNCS.draw_from_deck_to_hand(cards_to_draw)
        return true
      end
    }))
  else
    play_cards_ref(e)
  end
end
