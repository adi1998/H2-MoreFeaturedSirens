modutil.mod.Path.Wrap("ApplyScyllaFightSpotlight", function (base, scylla, args)
    local lastFlag = base(scylla, args)
    if lastFlag then
        game.RemoveValue( args.Flags, lastFlag )
        local extra_siren_count = config.featured_siren_count - 1
        if game.CurrentRun.CurrentRoom.Name == "G_Boss01" then
            extra_siren_count = math.min(2, extra_siren_count)
        end
        for _ = 1, extra_siren_count do
            game.wait(0.25)
            lastFlag = base(scylla, args)
            game.RemoveValue( args.Flags, lastFlag )
        end
    else
        rom.log.warning("Unable to get vanilla featured Siren, lovely patch likely broken. Skipping multiple featured Sirens.")
    end
end)