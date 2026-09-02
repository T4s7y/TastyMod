SMODS.ConsumableType {
  key = "Scraps",
  primary_colour = HEX("7B5E57"),    
  secondary_colour = HEX("4A3B32"),
  loc_txt = {
    name = "Scraps",
    collection = "Scrap Cards",
    label = "Scrap",
    group_name = "Scrap Pack",
    undiscovered = {
      name = "Undiscovered Scrap",
      text = { "Find this card in a", "Scrap Pack to learn", "what it does" }
    }
  },
  shop_rate = 1.6, 
  use_hand = true,
  default = "c_tm_scrap_default" 
}
SMODS.Booster {
  key = "scrap_pack_1",
  kind = "Scraps",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  config = { choose = 1, extra = 3 },
  cost = 4,
  order = 1,
  weight = 0.8,

  create_card = function(self, card)
    return create_card("Scraps", G.pack_cards, nil, nil, true, true, "nil", "scrap_pack")
  end,

  loc_txt = {
    name = "Scrap Pack",
    text = {
      "Choose {C:attention}#1#{} of up to",
      "{C:attention}#2# Scrap{} cards to",
      "be used immediately"
    }
  },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.config.center.config.extra } }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, HEX("7B5E57"))
  end,

  particles = function(self)
  end
}

SMODS.Booster {
  key = "jumbo_scrap_pack",
  kind = "Scraps",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  config = { choose = 1, extra = 5 },
  cost = 6,
  order = 2,
  weight = 0.6,

  create_card = function(self, card)
    return create_card("Scraps", G.pack_cards, nil, nil, true, true, "nil", "jumbo_scrap")
  end,

  loc_txt = {
    name = "Jumbo Scrap Pack",
    text = {
      "Choose {C:attention}#1#{} of up to",
      "{C:attention}#2# Scrap{} cards to",
      "be used immediately"
    }
  },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.config.center.config.extra } }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, HEX("7B5E57"))
  end,

  particles = function(self)
  end
}

SMODS.Booster {
  key = "mega_scrap_pack",
  kind = "Scraps",
  atlas = "tm_jokers",
  pos = { x = 0, y = 0 },
  config = { choose = 2, extra = 5 },
  cost = 8,
  order = 3,
  weight = 0.4,

  create_card = function(self, card)
    return create_card("Scraps", G.pack_cards, nil, nil, true, true, "nil", "mega_scrap")
  end,

  loc_txt = {
    name = "Mega Scrap Pack",
    text = {
      "Choose {C:attention}#1#{} of up to",
      "{C:attention}#2# Scrap{} cards to",
      "be used immediately"
    }
  },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.config.center.config.choose, card.config.center.config.extra } }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, HEX("7B5E57"))
  end,

  particles = function(self)
  end
}
