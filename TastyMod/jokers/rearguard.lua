SMODS.Joker {
  key = "rearguard",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  rarity = 1, 
  cost = 4,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,

  config = { 
    extra = { 
      repetitions = 1 
    } 
  },

  loc_txt = {
    name = "Rearguard",
    text = {
      "Retrigger the {C:attention}last 2{} played cards",
      "used in scoring {C:attention}#1#{} additional time"
    }
  },

  loc_vars = function(self, info_queue, card)
    return { 
      vars = { 
        card.ability.extra.repetitions 
      } 
    }
  end,

  calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play then
      local scoring_hand = context.scoring_hand or {}
      local total_cards = #scoring_hand

      for i, scoring_card in ipairs(scoring_hand) do
        if scoring_card == context.other_card then
          if i == total_cards or i == (total_cards - 1) then
            return {
              message = "Again!",
              repetitions = card.ability.extra.repetitions,
              card = card
            }
          end
        end
      end
    end
  end
}
