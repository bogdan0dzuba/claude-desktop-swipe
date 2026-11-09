-- claude-desktop-swipe: maps two-finger trackpad swipes to Back and Forward
-- in Claude for Desktop only, while preserving normal scrolling.
-- Copyright (c) 2026 Bohdan Dzuba. Licensed under the MIT License.
-- https://github.com/bogdan0dzuba/claude-desktop-swipe
-- Two-finger swipe left/right = Back/Forward, only in the Claude app.
local BUNDLE = "com.anthropic.claudefordesktop"
local THRESHOLD = 120
local types, props = hs.eventtap.event.types, hs.eventtap.event.properties
local sumX, sumY, fired = 0, 0, false
local function claudeFront()
  local app = hs.application.frontmostApplication()
  return app and app:bundleID() == BUNDLE
end
claudeSwipeTap = hs.eventtap.new({ types.scrollWheel }, function(e)
  if e:getProperty(props.scrollWheelEventIsContinuous) ~= 1 then return false end
  if e:getProperty(props.scrollWheelEventMomentumPhase) ~= 0 then return false end
  local phase = e:getProperty(props.scrollWheelEventScrollPhase)
  if phase == 1 then sumX, sumY, fired = 0, 0, false end
  if phase == 4 or phase == 8 then sumX, sumY, fired = 0, 0, false; return false end
  if fired or not claudeFront() then return false end
  sumX = sumX + e:getProperty(props.scrollWheelEventPointDeltaAxis2)
  sumY = sumY + e:getProperty(props.scrollWheelEventPointDeltaAxis1)
  if math.abs(sumX) > THRESHOLD and math.abs(sumX) > 2.5 * math.abs(sumY) then
    fired = true
    hs.eventtap.keyStroke({ "cmd" }, ((hs.mouse.scrollDirection() == "natural") == (sumX > 0)) and "[" or "]", 0)
  end
  return false
end)
claudeSwipeTap:start()
-- keep alive: restart the tap if macOS disables it
claudeSwipeWatch = hs.timer.doEvery(10, function()
  if not claudeSwipeTap:isEnabled() then claudeSwipeTap:start() end
end)
return claudeSwipeTap
