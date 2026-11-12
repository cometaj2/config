-- Remove size constraints and center constraints for Steam and Friends List, disable float, etc.
o.window({ class = "steam", title = "Steam" }, {
    float = false,
    center = false,
    size = nil,
})

o.window({ class = "steam", title = "Friends List" }, {
    float = false,
    center = false,
    size = nil,
})

-- General Steam class rules
o.window({ class = "steam" }, {
    float = false,
})

o.window({ class = "^steam.*$" }, {
    opacity = "1.0", "1.0",
})

o.window({ class = "steam" }, {
    idle_inhibit = "fullscreen",
})
