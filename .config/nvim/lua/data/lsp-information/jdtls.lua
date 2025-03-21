local fsUtils = require("utils.fs")
local projectName = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local masonPath = vim.fn.expand("$HOME/.local/share/nvim/mason")
local bundles = {
	vim.fn.glob(vim.fn.expand(masonPath .. "/share" .. "/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar")),
}
local launcherPath = vim.fn.glob(masonPath .. "/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar")
local configurationDirectory = masonPath .. "/packages/jdtls/config_linux"
local workspaceDirectory = vim.fn.expand("$HOME/.cache/jdtls/workspace/" .. projectName)
local extraArgs = {
	"-javaagent:" .. masonPath .. "/packages/jdtls/lombok.jar",
}
local rootDirectory = fsUtils.searchDirectoryUp({ "gradlew", "mvnw", "pom.xml" }, fsUtils.currentBufferDirectory())

return {
	lazy = true,
	fileTypes = "java",
	configuration = {
		cmd = {
			vim.fn.expand("$JAVA_HOME/bin/java"),
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
			unpack(extraArgs),
			"-jar",
			launcherPath,
			"-configuration",
			configurationDirectory,
			"-data",
			workspaceDirectory,
		},
		root_dir = rootDirectory,
		settings = {
			java = {},
		},
		init_options = {
			bundles = bundles,
		},
	},
}
