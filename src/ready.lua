modutil.mod.Path.Wrap("ApplyScyllaFightSpotlight", function (base, scylla, args)
    local lastFlag = base(scylla, args)
    if lastFlag then
        game.RemoveValue( args.Flags, lastFlag )
        local extra_siren_count = config.featured_siren_count - 1
        local available_siren_count = game.TableLength(args.Flags)
        print("Number of active unfeatured Sirens:", available_siren_count)
        print("Max number of featured Siren allowed:", config.featured_siren_count)
        extra_siren_count = math.min(extra_siren_count, available_siren_count)
        for _ = 1, extra_siren_count do
            game.wait(0.05)
            lastFlag = base(scylla, args)
            game.RemoveValue( args.Flags, lastFlag )
        end
    else
        rom.log.warning("Unable to get vanilla featured Siren, lovely patch likely broken. Skipping multiple featured Sirens.")
    end
    return lastFlag
end)

-- limit this to be called max once per room
modutil.mod.Path.Wrap("ScyllaSpotlightPresentation", function (base, ...)
    if game.MapState[_PLUGIN.guid .. "ScyllaSpotlightPresentationAlreadyRun"] then
        return
    end
    game.MapState[_PLUGIN.guid .. "ScyllaSpotlightPresentationAlreadyRun"] = true
    return base(...)
end)