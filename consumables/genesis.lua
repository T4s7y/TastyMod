SMODS.Consumable {
  key = 'genesis',
  set = 'Spectral',
  atlas = 'tm_jokers', 
  pos = { x = 0, y = 0 },
  cost = 4,
  unlocked = true,
  discovered = true,
  loc_txt = {
    name = 'Genesis',
    text = {
      'Add a {C:attention}Clone Seal{} to',
      '{C:attention}1{} selected card in hand'
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_SEALS.tm_clone_seal
    return { vars = {} }
  end,

  can_use = function(self, card)
    return G.hand and #G.hand.highlighted == 1
  end,

  use = function(self, card, area, copier)
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)

        local target = G.hand.highlighted[1]
        if target then target:flip() end
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.5,
      func = function()
        play_sound('tarot2')
        local target = G.hand.highlighted[1]
        if target then
          target:set_seal('tm_clone_seal', nil, true)
        end
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.2,
      func = function()
        if G.hand.highlighted[1] then
          G.hand.highlighted[1]:juice_up(0.3, 0.3)
        end
        G.hand:unhighlight_all()
        return true
      end
    }))
  end
}
