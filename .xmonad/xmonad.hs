import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

main = xmonad $ def
    { borderWidth        = 3
    , terminal           = "kitty"
    , normalBorderColor  = "#928374"
    , focusedBorderColor = "#d79921"
    , focusFollowsMouse  = False
    , clickJustFocuses   = False
    , handleEventHook    = handleEventHook def
    , layoutHook         = layoutHook'
    } `removeKeysP`
    [ "M-h"
    , "M-j"
    , "M-k"
    , "M-l"
    , "M-S-j"
    , "M-S-k"
    ] `additionalKeysP`
    [ ("M-d",   spawn "$HOME/.config/rofi/run-custom-launcher.sh")
    , ("M-r",   spawn "rofi -show drun")
    , ("M-j",   sendMessage Shrink)
    , ("M-n",   windows W.focusDown)
    , ("M-e",   windows W.focusUp)
    , ("M-i",   sendMessage Expand)
    , ("M-S-n", windows W.swapDown)
    , ("M-S-e", windows W.swapUp)
    ]

layoutHook' = spacingRaw True (Border 10 10 10 10) False (Border 10 10 10 10) False $
              smartBorders $
              layoutHook def

