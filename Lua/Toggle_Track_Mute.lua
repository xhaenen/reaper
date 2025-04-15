--[[
 * ReaScript Name: Toggle Mute for Selected Tracks
 * Description: Toggles mute state for all selected tracks
 * Author: Your Name
 * Version: 1.0
 * Date: 2023
--]]

function main()
  -- Get number of selected tracks
  local track_count = reaper.CountSelectedTracks(0)
  
  if track_count == 0 then
    reaper.ShowMessageBox("Please select at least one track.", "No Tracks Selected", 0)
    return
  end
  
  -- Begin undo block
  reaper.Undo_BeginBlock()
  
  -- Toggle mute for each selected track
  for i = 0, track_count - 1 do
    local track = reaper.GetSelectedTrack(0, i)
    local mute_state = reaper.GetMediaTrackInfo_Value(track, "B_MUTE")
    reaper.SetMediaTrackInfo_Value(track, "B_MUTE", 1 - mute_state)
  end
  
  -- End undo block
  reaper.Undo_EndBlock("Toggle mute for selected tracks", -1)
  
  -- Update UI
  reaper.UpdateArrange()
end

main() 