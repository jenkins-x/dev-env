package main

import (
	"os"
	"os/exec"

	"github.com/cloudflare/cfssl/log"
)

func run() error {
	cmd := exec.Command("docker",
		"run",
		"--rm",
		"--interactive",
		"--tty",
		"--env", "TERM=screen-256color-bce",
		"gcr.io/jenkinsxio/dev-env-base:0.0.13-go-alpine",
		"tmux",
		"-u",
	)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	cmd.Stdin = os.Stdin
	err := cmd.Run()
	if err != nil {
		log.Errorf("%e\n", err)
	}
	return nil
}

func main() {
	err := run()
	if err != nil {
		log.Errorf("Error: %e\n", err)
	}
}
