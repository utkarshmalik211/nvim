local v = require('modules.semver')
local Automation = {}

function Automation.GitPush()
	local currBranch = string.gsub( Automation.execCommand("git branch --show-current"), '%s+', '') 
	print(Automation.execCommand("git push origin "..currBranch))
end

function Automation.GitPull()
	local currBranch = string.gsub( Automation.execCommand("git branch --show-current"), '%s+', '') 
	print(Automation.execCommand("git pull origin "..currBranch))
end

function Automation.ReleaseTag()
	local currBranch = string.gsub( Automation.execCommand("git branch --show-current"), '%s+', '') 
	--stash current work
	print("Stash: " .. Automation.execCommand("git stash && git fetch --tags"))
	-- pull latest
	print("Pull latest: " .. Automation.execCommand("git checkout dev && git pull origin dev && git checkout main && git pull origin main") .. "\n")
	-- merge dev
	print("Merge: " .. Automation.execCommand("git merge dev --no-ff -X thiers --no-edit") .. "\n")
	local lastTag = Automation.execCommand("git describe --tags $(git rev-list --tags --max-count=1)")
	local newTag = v(lastTag:sub(2)):nextPatch()
	print("Create tag: " .. Automation.execCommand("git tag v"..newTag))
	print("Push: " .. Automation.execCommand("git push origin v"..newTag.." && git push origin main"))
	print("Back to current: " .. Automation.execCommand("git checkout "..currBranch.." && git stast pop"))
end

function Automation.execCommand(command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()
	return result
end
return Automation
