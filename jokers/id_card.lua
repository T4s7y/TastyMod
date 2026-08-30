SMODS.Joker {
  key = "id_card",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 1,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,

  config = {
    extra = {
      Xmult = 2,
      threshold = 21
    }
  },

  loc_txt = {
    name = "ID Card",
    text = {
      "{X:mult,C:white}X#1#{} Mult if the {C:chips}chip{} sum",
      "of cards used in scoring is",
      "greater or equal to {C:attention}#2#{}"
    }
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.Xmult,
        card.ability.extra.threshold
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main and context.scoring_hand then
      local total_sum = 0

      for _, scoring_card in ipairs(context.scoring_hand) do
        if scoring_card:is_face() then
          total_sum = total_sum + 10
        elseif scoring_card:get_id() == 14 then
          total_sum = total_sum + 11
        else
          total_sum = total_sum + (scoring_card.base.nominal or 0)
        end
      end

      if total_sum >= card.ability.extra.threshold then
        return {
          message = "X" .. card.ability.extra.Xmult .. " Mult",
          Xmult_mod = card.ability.extra.Xmult,
          colour = G.C.MULT
        }
      end
    end
  end
}
