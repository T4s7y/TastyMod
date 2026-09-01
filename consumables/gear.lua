SMODS.Consumable {
  key = "gear",
  set = "Scraps", 
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  cost = 3,
  unlocked = true,
  discovered = true,
  in_pool = function(self, args)
    return false
  end,
  config = {
    max_highlighted = 1
  },

  loc_txt = {
    name = "Gear",
    text = {
      "Destroy {C:attention}1{} selected",
      "card in hand"
    }
  },

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
      delay = 0.3,
      func = function()
        target.destroyed = true
        
        target:start_dissolve()
        
        G.hand:remove_card(target)
        target:remove()
        
        return true
      end
    }))
  end,

  can_use = function(self, card)
    return #G.hand.highlighted == 1
  end
}
