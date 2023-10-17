(declare-project
  :name "legimi-downloader"
  :description "Unofficial Legimi ebook downloader for Kindle and Linux"
  :dependencies ["https://github.com/joy-framework/http"])

(def- sources ["src/legimi"])
(def- dev-deps ["spork"])

(declare-source
  :source sources)

(defn- remove-prefix
  [prefix str]
  (if (string/has-prefix? prefix str)
    (string/slice str (length prefix))
    str))

(defn- safe-link
  [src-dir dest-dir src-file &opt dest-file]
  (default dest-file src-file)
  (try
    (os/link (string src-dir "/" src-file)
             (string dest-dir "/" dest-file)
             true)
    ([err] (eprint err))))

(task "dev-setup" []
  (let [src-path (string (os/getenv "HOME") "/.local/lib/janet")
        dest-path (string (os/cwd) "/jpm_tree/lib")]
    (each dep dev-deps
      (safe-link src-path dest-path dep))
    (each source sources
      (safe-link (os/cwd) dest-path
            source (remove-prefix "src/" source)))))

(task "live-test" []
      (run-tests "testlive"))
