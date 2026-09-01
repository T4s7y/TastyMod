SMODS.Enhancement {
  key = "cosmic",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },

  loc_txt = {
    name = "Cosmic Card",
    text = {
      "Creates a random {C:spectral}Spectral{} card",
      "when {C:attention}destroyed{}",
      "{C:inactive}(Must have space){}"
    }
  },
  calculate = function(self, card, context)
    local is_destroyed = false
    
    if context.destroying_card and context.destroying_card == card then
      is_destroyed = true
    elseif context.remove_playing_cards then
      for _, c in ipairs(context.removed or {}) do
        if c == card then
          is_destroyed = true
          break
        end
      end
    end

    if is_destroyed then
      if #G.consumeables.cards < G.consumeables.config.card_limit then
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.4,
          func = function()
            play_sound("timpani")
            
            local new_card = create_card("Spectral", G.consumeables, nil, nil, nil, nil, nil, "cosmic")
            new_card:add_to_deck()
            G.consumeables:emplace(new_card)
            
            return true
          end
        }))
      end
    end
  end
}
