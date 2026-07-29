hl.layout.register("deck", {
    recalculate = function(ctx)
        local n = #ctx.targets
        if n == 0 then return end
        if n == 1 then
            ctx.targets[1]:place(ctx.area)
            return
        end
        local strip = 40
        for i, target in ipairs(ctx.targets) do
            local off = (n - i) * strip
            target:place({x = ctx.area.x + off, y = ctx.area.y + off,
                          w = ctx.area.w - off * 2, h = ctx.area.h - off * 2})
        end
    end,
})
