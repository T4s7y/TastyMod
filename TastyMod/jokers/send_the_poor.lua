SMODS.Joker {
  key = "send_the_poor",
  atlas = "tm_jokers", 
  loc_txt = {
    name = "Send The Poor",
    text = {
      "If played hand contains {C:attention}5{} scoring cards",
      "and their {C:chips}Chip{} sum is {C:attention}less than 16{},",
      "{C:red}destroy{} all scored cards",
    }
  },
  config = { extra = { card_count = 5, chip_threshold = 16 } },
  pos = { x = 0, y = 0 },
  rarity = 3,
  cost = 8,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,

  calculate = function(self, card, context)
    if context.before and context.scoring_hand and #context.scoring_hand == card.ability.extra.card_count then
      local chip_sum = 0
      for _, scored_card in ipairs(context.scoring_hand) do
        chip_sum = chip_sum + (scored_card.base.nominal or 0)
      end

      if chip_sum < card.ability.extra.chip_threshold then
        card_eval_status_text(card, 'extra', nil, nil, nil, {
          message = "Why do we always send the poor?",
          colour = G.C.RED
        })
      end
    end

    if context.destroying_card and context.scoring_hand then
      local scored = context.scoring_hand

      if #scored == card.ability.extra.card_count then
        local chip_sum = 0
        for _, scored_card in ipairs(scored) do
          chip_sum = chip_sum + (scored_card.base.nominal or 0)
        end

        if chip_sum < card.ability.extra.chip_threshold then
          G.GAME.cards_destroyed = (G.GAME.cards_destroyed or 0) + 1
          return true
        end
      end
    end
  end,
}
