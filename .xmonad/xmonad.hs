import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig

main = xmonad $ def
    { borderWidth        = 3
    , terminal           = "urxvt"
    , normalBorderColor  = "#928374"
    , focusedBorderColor = "#d79921"
    , focusFollowsMouse  = False
    , clickJustFocuses   = False
    , handleEventHook    = handleEventHook def
    , layoutHook         = layoutHook'
    } `additionalKeys`
    [ ((mod1Mask, xK_d), spawn "$HOME/.config/rofi/run-custom-launcher.sh")
    , ((mod1Mask, xK_r), spawn "rofi -show drun")
    , ((mod1Mask, xK_Escape), windows W.focusUp)
    ]

layoutHook' = spacingRaw True (Border 10 10 10 10) True (Border 10 10 10 10) True $
              smartBorders $
              layoutHook def

