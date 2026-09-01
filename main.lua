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
SMODS.load_file("jokers/or_gate.lua")()
SMODS.load_file("jokers/monolith.lua")()
SMODS.load_file("jokers/gambler.lua")()
SMODS.load_file("jokers/emergency_slippers.lua")()
SMODS.load_file("jokers/donut_hole.lua")()
SMODS.load_file("jokers/lackie.lua")()
SMODS.load_file("jokers/psychic.lua")()
SMODS.load_file("jokers/astrologist.lua")()
SMODS.load_file("jokers/bank.lua")()
SMODS.load_file("jokers/id_card.lua")()
SMODS.load_file("jokers/introverted_joker.lua")()
SMODS.load_file("jokers/cuck_chair.lua")()


-- Spectral Cards
SMODS.load_file("consumables/gluttony.lua")()
SMODS.load_file("consumables/glory.lua")()
SMODS.load_file("consumables/summon_forth.lua")()
SMODS.load_file("consumables/dying_star.lua")()
SMODS.load_file("consumables/glamour.lua")()
SMODS.load_file("consumables/genesis.lua")()


-- Seals
SMODS.load_file("seals/grey_seal.lua")()
SMODS.load_file("seals/orange_seal.lua")()
SMODS.load_file("seals/void_seal.lua")()
SMODS.load_file("seals/clone_seal.lua")()

-- Scraps
SMODS.load_file("consumable_types/scraps.lua")()
SMODS.load_file("consumables/calcium.lua")()
SMODS.load_file("consumables/thirst.lua")()
SMODS.load_file("consumables/royalty.lua")()
SMODS.load_file("consumables/irony.lua")()
SMODS.load_file("consumables/eclipse.lua")()
SMODS.load_file("consumables/technology.lua")()
SMODS.load_file("consumables/gear.lua")()
SMODS.load_file("consumables/greed.lua")()

-- Enhancements
SMODS.load_file("enhancements/bone.lua")()
SMODS.load_file("enhancements/blood.lua")()
SMODS.load_file("enhancements/loyal.lua")()
SMODS.load_file("enhancements/cosmic.lua")()
SMODS.load_file("enhancements/mech.lua")()
SMODS.load_file("enhancements/rare.lua")()

SMODS.current_mod.reset_game_data = function()
  G.GAME.loyalty_counter = 0
  G.GAME.last_scrap_or_spectral = nil
end

local consumable_use_ref = Card.use_consumeable
function Card.use_consumeable(self, area, copier)
  if self.ability.set == "Spectral" or self.ability.set == "Scraps" then
    if self.config.center.key ~= "c_tm_irony" then
      G.GAME.last_scrap_or_spectral = self.config.center.key
    end
  end
  return consumable_use_ref(self, area, copier)
end

local draw_ref = Card.draw
function Card:draw(layer)
  if self.config and self.config.center and self.config.center.key == "m_tm_blood" then
    local tier = self.ability and self.ability.blood_tier or 1
    local atlas_key = "tm_blood_tier_" .. math.min(3, tier)
    if self.config.center.atlas ~= atlas_key then
      if G.ASSET_ATLAS[atlas_key] then
        self.config.center.atlas = atlas_key
        if self.children and self.children.center then
          self.children.center.atlas = G.ASSET_ATLAS[atlas_key]
        end
      end
    end
  end
  draw_ref(self, layer)
end
