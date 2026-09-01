SMODS.Atlas {
  key = "tm_blood_tier_1",
  path = "blood_tier_1.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "tm_blood_tier_2",
  path = "blood_tier_2.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "tm_blood_tier_3",
  path = "blood_tier_3.png",
  px = 71,
  py = 95
}

SMODS.Enhancement {
  key = "blood",
  atlas = "tm_blood_tier_1", 
  pos = { x = 0, y = 0 },

  loc_txt = {
    name = "Blood Card",
    text = {
      "{C:mult}Blood{} Tier gets upgraded with each",
      "{C:attention}Thirst{} card used",
      "{C:mult}Blood{} Tier I: {C:mult}+3{} mult",
      "{C:mult}Blood{} Tier II: {C:mult}+10{} mult",
      "{C:mult}Blood{} Tier III: {X:mult,C:white}X1.5{} mult",
      "Previous Tier effects get",
      "{C:attention}carried over{} to higher Tiers",
      "{C:inactive}(Currently Tier #1#){}"
    }
  },

  set_ability = function(self, card, initial, delay_sprites)
    card.ability.blood_tier = card.ability.blood_tier or 1
    local tier = card.ability.blood_tier
  end,

  loc_vars = function(self, info_queue, card)
    local tier = card and card.ability and card.ability.blood_tier or 1
    local roman = { "I", "II", "III" } 
    return { vars = { roman[tier] or "I" } }
  end,

  calculate = function(self, card, context, effect)
    if context.main_scoring and context.cardarea == G.play then
      local tier = card.ability.blood_tier or 1
      
      local mult_val = 0
      local xmult_val = 1

      if tier >= 1 then
        mult_val = mult_val + 3
      end

      if tier >= 2 then
        mult_val = mult_val + 10
      end

      if tier >= 3 then
        xmult_val = 1.5
      end

      if tier >= 3 then
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.5,
          func = function()
            card:juice_up(0.6, 0.6)

            local p = Particles(card.VT.x + card.VT.w / 2, card.VT.y + card.VT.h / 2, 0, 0, {
              timer = 0.01,
              scale = 0.6,
              speed = 2,
              lifespan = 0.5, 
              attach = card, 
              colours = { G.C.MULT, HEX("8b0000") },
              fill = true
            })
            p:fade(0.5)

            return true
          end
        }))
      end

      return {
        mult = mult_val > 0 and mult_val or nil,
        x_mult = xmult_val > 1 and xmult_val or nil
      }
    end
  end
}

local function update_blood_atlas(card)
  local tier = card.ability and card.ability.blood_tier or 1
  local atlas_key = "tm_blood_tier_" .. math.min(3, tier)

  if G.ASSET_ATLAS[atlas_key] then
    card.config.center.atlas = atlas_key

    if card.children and card.children.center then
      card.children.center.atlas = G.ASSET_ATLAS[atlas_key]
    end
  end
end

local set_ability_ref = Card.set_ability
function Card.set_ability(self, center, initial, delay_sprites)
  set_ability_ref(self, center, initial, delay_sprites)

  if self.config and self.config.center and self.config.center.key == "m_tm_blood" then
    update_blood_atlas(self)
  end
end

function apply_blood_to_card(card)
  if card.config.center.key == "m_tm_blood" then
    card.ability.blood_tier = math.min(3, (card.ability.blood_tier or 1) + 1)
  else
    card:set_ability(G.P_CENTERS.m_tm_blood)
    card.ability.blood_tier = 1
  end

  update_blood_atlas(card)

  card_eval_status_text(card, "extra", nil, nil, nil, {
    message = "Tier " .. card.ability.blood_tier .. "!",
    colour = G.C.MULT
  })
end
