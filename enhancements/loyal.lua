SMODS.Enhancement {
  key = "loyal",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },

  loc_txt = {
    name = "Loyal Card",
    text = {
      "This card is placed at",
      "the {C:attention}top of the deck{}",
      "at the start of each round"
    }
  },

  set_ability = function(self, card, initial, delay_sprites)
    if not card.ability.loyalty_timestamp then
      G.GAME.loyalty_counter = (G.GAME.loyalty_counter or 0) + 1
      card.ability.loyalty_timestamp = G.GAME.loyalty_counter
    end
  end,
}

local draw_from_deck_to_hand_ref = G.FUNCS.draw_from_deck_to_hand
G.FUNCS.draw_from_deck_to_hand = function(e)
  if G.deck and G.deck.cards then
    local loyal_cards = {}
    local other_cards = {}

    for _, c in ipairs(G.deck.cards) do
      if c.config and c.config.center and c.config.center.key == "m_tm_loyal" then
        table.insert(loyal_cards, c)
      else
        table.insert(other_cards, c)
      end
    end

    table.sort(loyal_cards, function(a, b)
      local time_a = a.ability and a.ability.loyalty_timestamp or 0
      local time_b = b.ability and b.ability.loyalty_timestamp or 0
      return time_a < time_b
    end)

    local new_deck = {}
    for _, c in ipairs(other_cards) do
      table.insert(new_deck, c)
    end
    for _, c in ipairs(loyal_cards) do
      table.insert(new_deck, c)
    end

    G.deck.cards = new_deck
  end

  return draw_from_deck_to_hand_ref(e)
end

