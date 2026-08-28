SMODS.Joker {
  key = 'monolith',
  atlas = 'tm_jokers', 
  pos = { x = 0, y = 0 },
  rarity = 3, 
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,

  loc_txt = {
    name = 'Monolith',
    text = {
      'This joker gains {X:mult,C:white}X0.2{} Mult per consecutive hand ',
      'played that is different from the last {C:attention}2{} played hands',
      '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)',
      '{C:inactive}(Last played hands: {C:attention}#2#{C:inactive}, {C:attention}#3#{C:inactive})'
    }
  },

  set_ability = function(self, card, initial, delay_sprites)
    card.ability.extra = {
      x_mult = 1,
      gain = 0.2,
      last_hands = { 'None', 'None' }
    }
  end,

  loc_vars = function(self, info_queue, card)
    local hands = card.ability.extra.last_hands or { 'None', 'None' }
    return {
      vars = {
        card.ability.extra.x_mult,
        hands[1] or 'None',
        hands[2] or 'None'
      }
    }
  end,
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      local current_hand = context.scoring_name
      local last_1 = card.ability.extra.last_hands[1]
      local last_2 = card.ability.extra.last_hands[2]

      if current_hand ~= last_1 and current_hand ~= last_2 then
        card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.gain
      else
        if card.ability.extra.x_mult > 1 then
          card.ability.extra.x_mult = 1
          card_eval_status_text(card, 'extra', nil, nil, nil, {
            message = 'Reset',
            colour = G.C.RED
          })
        end
      end

      card.ability.extra.last_hands[2] = card.ability.extra.last_hands[1]
      card.ability.extra.last_hands[1] = current_hand
    end

    if context.joker_main then
      if card.ability.extra.x_mult > 1 then
        return {
          message = 'X' .. card.ability.extra.x_mult,
          Xmult_mod = card.ability.extra.x_mult,
          colour = G.C.MULT
        }
      end
    end
  end
}
