SHELL := /bin/bash
src := ~/project/source
dst := ~/project/dest
interval := 20
maxb := 5

.PHONY: backup
backup:
	@echo "running backup"
	./backupd.sh $(src) $(dst) $(interval) $(maxb)


.PHONY: restore
restore:
	@echo "running restore"
	./restore.sh $(src) $(dst)