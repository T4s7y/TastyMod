SMODS.Enhancement {
  key = "mech",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },

  loc_txt = {
    name = "Mech Card",
    text = {
      "Creates {C:attention}Gear{} card",
      "when this card is scored"
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.c_tm_gear
    return { vars = {} }
  end,

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      if #G.consumeables.cards < G.consumeables.config.card_limit then
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.4,
          func = function()
            play_sound("timpani")
            
            local new_card = create_card("Consumable", G.consumeables, nil, nil, nil, nil, "c_tm_gear")
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            
            card:juice_up(0.5, 0.5)
            return true
          end
        }))
      end
    end
  end
}
