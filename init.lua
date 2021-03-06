local names = {
  ["OSX-x64"] = "luatweetnacl.so",
  ["Linux-x64"] = "luatweetnacl.so",
  ["Linux-arm"] = "luatweetnacl.so",
}
local ffi = require 'ffi'
local arch = ffi.os .. "-" .. ffi.arch
assert(names[arch], "No prebuilt binary for luatweetnacl for " .. arch)

return require('./' .. arch .. '/' .. names[arch])
