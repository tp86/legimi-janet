(declare-project
  :name "legimi-downloader"
  :description "Unofficial Legimi ebook downloader for Kindle and Linux"
  :dependencies ["https://github.com/joy-framework/http"])

(def sources ["src/legimi"])

(declare-source
  :source sources)

(task "dev-setup" []
  (let [src-path (string (os/getenv "HOME") "/.local/lib/janet")
        dest-path (string (os/cwd) "/jpm_tree/lib")
        dev-deps ["spork"]]
    (each dep dev-deps
      (try
        (os/link (string src-path "/" dep) (string dest-path "/" dep) true)
        ([err] (eprint err))))
    (each source sources
      (try
        (os/link (string (os/cwd) "/" source)
                 (string dest-path "/" (if (= (string/slice source 0 4) "src/")
                                          (string/slice source 4)
                                          source))
                 true)
        ([err] (eprint err))))))

(task "live-test" []
      (run-tests "testlive"))
