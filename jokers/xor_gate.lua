SMODS.Joker {
  key = 'xor_gate',
  atlas = 'tm_jokers', 
  pos = { x = 0, y = 0 },
  rarity = 2, 
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,

  loc_txt = {
    name = 'XOR Gate',
    text = {
      '{X:mult,C:white}X3{} Mult if the bitwise {C:attention}XOR{} sum',
      'of scored cards equals {C:attention}#1#{}',
      '{C:inactive}(Target changes every round)'
    }
  },

  set_ability = function(self, card, initial, delay_sprites)
    card.ability.extra = {
      x_mult = 3,
      target_val = math.floor(pseudorandom('bitwise_init') * 16), 
    }
  end,

  loc_vars = function(self, info_queue, card)
    local target = card.ability.extra.target_val or 0
    local str = ""
    for i = 3, 0, -1 do
      local b = math.floor(target / (2 ^ i)) % 2
      str = str .. tostring(b)
    end

    return {
      vars = {
        str
      }
    }
  end,

  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      card.ability.extra.target_val = math.floor(pseudorandom('bitwise_round') * 16)
      
      local target = card.ability.extra.target_val
      local str = ""
      for i = 3, 0, -1 do
        local b = math.floor(target / (2 ^ i)) % 2
        str = str .. tostring(b)
      end

      card_eval_status_text(card, 'extra', nil, nil, nil, {
        message = "Target: " .. str,
        colour = G.C.FILTER
      })
    end

    if context.joker_main then
      local xor_sum = 0

      for i = 1, #context.scoring_hand do
        local card_val = context.scoring_hand[i]:get_id()
        if card_val > 0 then
          xor_sum = bit.bxor(xor_sum, card_val)
        end
      end

      if xor_sum == card.ability.extra.target_val then
        return {
          message = 'X3',
          Xmult_mod = card.ability.extra.x_mult,
          colour = G.C.MULT
        }
      end
    end
  end
}
