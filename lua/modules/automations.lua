local Automation = {}

function Automation.GitPush()
	local currBranch = string.gsub( Automation.execCommand("git branch --show-current"), '%s+', '') 
	print(Automation.execCommand("git push origin "..currBranch))
end

function Automation.execCommand(command)
	local handle = io.popen(command)
	local result = handle:read("*a")
	handle:close()
	return result
end
return Automation
