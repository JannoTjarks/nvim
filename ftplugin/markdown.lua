local map = require("janno.utils").map
map("n", "<leader>O", function()
    local currentLine = vim.fn.getline(".")
    local urlPattern =
    "https://[-a-zA-Z0-9@:%._%+~#=]*%.[a-zA-Z0-9()]*[-a-zA-Z0-9@:%_%+.~#?&//=]*"

    local url = string.match(currentLine, urlPattern)
    if url == nil then
        print("No URL found in this line!")
        return
    end

    local confirmation = vim.fn.input("Do you want to open the url " .. url .. "? (y)es/(N)o: ")
    if confirmation == "y" or confirmation == "Y" then
        vim.ui.open(url)
        return
    end

    print("canceled")
end)
