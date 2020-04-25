import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing

main = xmonad def
    { borderWidth        = 3
    , terminal           = "urxvt"
    , normalBorderColor  = "#928374"
    , focusedBorderColor = "#d79921"
    , focusFollowsMouse  = False
    , clickJustFocuses   = False
    , handleEventHook    = handleEventHook def
    , layoutHook         = layoutHook'
    }

layoutHook' = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True $
              smartBorders $
              layoutHook def
