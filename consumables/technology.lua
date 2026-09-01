SMODS.Consumable {
  key = "technology",
  set = "Scraps",
  atlas = "tm_jokers", 
  pos = { x = 0, y = 0 },
  cost = 3,
  unlocked = true,
  discovered = true,
  config = {
    max_highlighted = 1
  },

  loc_txt = {
    name = "Technology",
    text = {
      "Enhances {C:attention}1{} selected card",
      "to a {C:attention}Mech Card{}"
    }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_tm_mech
    return { vars = {} }
  end,

  use = function(self, card, area, copier)
    local target = G.hand.highlighted[1]

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        play_sound("tarot1")
        card:juice_up(0.5, 0.5)
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.15,
      func = function()
        target:flip()
        play_sound("card1", 1)
        target:juice_up(0.3, 0.3)
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.2,
      func = function()
        target:set_ability(G.P_CENTERS.m_tm_mech)
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = "after",
      delay = 0.25,
      func = function()
        target:flip()
        play_sound("tarot2", 1, 0.6)
        return true
      end
    }))
  end,

  can_use = function(self, card)
    return #G.hand.highlighted == 1
  end
}
