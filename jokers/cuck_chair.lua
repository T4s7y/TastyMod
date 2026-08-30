SMODS.Joker {
  key = "cuck_chair",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 2,
  cost = 7,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,

  config = {
    extra = {
      Xmult = 1,
      Xmult_mod = 0.5
    }
  },

  loc_txt = {
    name = "Cuck Chair",
    text = {
      "Gains {X:mult,C:white}X#2#{} Mult if played hand",
      "contains a scoring {C:attention}Queen{} and {C:attention}Jack{},",
      "while a {C:attention}King{} is held in hand",
      "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)"
    }
  },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.Xmult,
        card.ability.extra.Xmult_mod
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local has_queen = false
      local has_jack = false
      local has_king_in_hand = false

      if context.scoring_hand then
        for _, scoring_card in ipairs(context.scoring_hand) do
          if scoring_card:get_id() == 12 then
            has_queen = true
          elseif scoring_card:get_id() == 11 then
            has_jack = true
          end
        end
      end

      if G.hand and G.hand.cards then
        for _, hand_card in ipairs(G.hand.cards) do
          if hand_card:get_id() == 13 then
            has_king_in_hand = true
            break
          end
        end
      end

      if has_queen and has_jack and has_king_in_hand then
        if not context.blueprint then
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
          card_eval_status_text(card, "extra", nil, nil, nil, {
            message = "Upgraded!",
            colour = G.C.MULT
          })
        end
      end

      if card.ability.extra.Xmult > 1 then
        return {
          message = "X" .. card.ability.extra.Xmult .. " Mult",
          Xmult_mod = card.ability.extra.Xmult,
          colour = G.C.MULT
        }
      end
    end
  end
}
