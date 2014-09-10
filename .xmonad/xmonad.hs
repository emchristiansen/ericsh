import           XMonad
import           XMonad.Config.Gnome
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.SetWMName
import           XMonad.Layout.ThreeColumns

import           XMonad.Actions.CycleWS
import           XMonad.Actions.UpdatePointer
import           XMonad.Actions.WindowBringer
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName
import           XMonad.Layout.Accordion
import           XMonad.Layout.Dishes
import           XMonad.Layout.Grid
import qualified XMonad.Layout.GridVariants   as GV
import           XMonad.Layout.MagicFocus
import           XMonad.Layout.Named
import           XMonad.Layout.NoBorders
import           XMonad.Layout.PerWorkspace
import           XMonad.Layout.Tabbed
import           XMonad.Prompt
import           XMonad.Prompt.DirExec
import           XMonad.Prompt.Workspace
import           XMonad.Util.Run

import qualified Data.Map                     as M

import           System.Exit
import qualified XMonad.StackSet              as W
import           XMonad.Util.EZConfig

myManageHook = composeAll (
    [ manageHook gnomeConfig
    , className =? "Unity-2d-panel" --> doIgnore
    , className =? "Unity-2d-launcher" --> doFloat
    , title =? "float" --> doFloat
    ])

myLayoutHook = avoidStruts $ (ThreeColMid 1 (2 / 100) (1 / 3)) ||| standardLayouts
 where
  tall = Tall 1 (2 / 100) (1 / 2)
  split = GV.SplitGrid GV.L 1 1 (1/2) (8/10) (5/100)
  standardLayouts = tall ||| Mirror tall ||| Full ||| Grid ||| split

myWorkspaces = map show [1 .. 21]

myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
    , ((modMask,               xK_p     ), spawn "dmenu_run") -- %! Launch dmenu
    , ((modMask .|. shiftMask, xK_p     ), spawn "gmrun") -- %! Launch gmrun
    , ((modMask .|. shiftMask, xK_c     ), kill) -- %! Close the focused windowimport XMonad

    , ((modMask,               xK_space ), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default

    , ((modMask,               xK_n     ), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
    , ((modMask,               xK_Tab   ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask .|. shiftMask, xK_Tab   ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_j     ), windows W.focusDown) -- %! Move focus to the next window
    , ((modMask,               xK_k     ), windows W.focusUp  ) -- %! Move focus to the previous window
    , ((modMask,               xK_m     ), windows W.focusMaster  ) -- %! Move focus to the master window

    -- modifying the window order
    , ((modMask,               xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  ) -- %! Swap the focused window with the next window
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    ) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
    , ((modMask,               xK_h     ), sendMessage Shrink) -- %! Shrink the master area
    , ((modMask,               xK_l     ), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- toggle the status bar gap
    --, ((modMask              , xK_b     ), modifyGap (\i n -> let x = (XMonad.defaultGaps conf ++ repeat (0,0,0,0)) !! i in if n == x then (0,0,0,0) else x)) -- %! Toggle the status bar gap

    -- quit, or restart
    --, ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- %! Quit xmonad
    , ((modMask .|. shiftMask, xK_r     ), spawn "if type xmonad; then xmonad --recompile && xmonad --restart; else xmessage xmonad not in \\$PATH: \"$PATH\"; fi") -- %! Restart xmonad
   ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1, xK_2, xK_3, xK_4, xK_5, xK_6, xK_7, xK_8, xK_9, xK_0] ++ [xK_q, xK_w, xK_e, xK_r] ++ [xK_a, xK_s, xK_d, xK_f] ++ [xK_z, xK_x, xK_v])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    -- ++
    -- -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    -- [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
    --     | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
    --     , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myConfig = gnomeConfig {
  manageHook = myManageHook,
  layoutHook = myLayoutHook,
  modMask = mod4Mask,
  -- startupHook = setWMName "LG3D",
  keys = myKeys,
  workspaces = myWorkspaces }

main = xmonad $ myConfig

-- main = xmonad gnomeConfig
--      { modMask = mod4Mask
--      }
