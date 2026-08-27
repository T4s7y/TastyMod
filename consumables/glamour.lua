SMODS.Consumable {
  key = 'glamour',
  set = 'Spectral',
  atlas = 'tm_jokers', 
  pos = { x = 0, y = 0 },

  loc_txt = {
    name = 'Glamour',
    text = {
      'Enhances up to {C:attention}3{} selected cards',
      'with a random {C:attention}Enhancement{}'
    }
  },

  can_use = function(self, card)
    return #G.hand.highlighted >= 1 and #G.hand.highlighted <= 3
  end,

  use = function(self, card, area, copier)
    local enhancement_key = pseudorandom_element(G.P_CENTER_POOLS.Enhanced, pseudoseed('glamour')).key

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)

        for i = 1, #G.hand.highlighted do
          local target = G.hand.highlighted[i]
          target:flip()
        end
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.5,
      func = function()
        play_sound('tarot2')
        for i = 1, #G.hand.highlighted do
          local target = G.hand.highlighted[i]
          target:set_ability(G.P_CENTERS[enhancement_key], nil, true)
          target:flip()
        end
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        for i = 1, #G.hand.highlighted do
          G.hand.highlighted[i]:juice_up(0.3, 0.3)
        end
        G.hand:unhighlight_all()
        return true
      end
    }))
  end}
