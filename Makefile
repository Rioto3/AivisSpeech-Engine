# ==========
# SETTINGS
# ==========

# Path to FastAPI project
API_DIR=spinning-api

# Path to AivisSpeech local engine
AIVIS_DIR=AivisSpeech-Engine

# Audio engine port
AIVIS_PORT=10101

# PIDs will be stored under ./.pids/
PID_DIR=.pids
PID_FASTAPI=$(PID_DIR)/fastapi.pid
PID_AIVIS=$(PID_DIR)/aivis.pid


# ==========
# UTILS
# ==========

init:
	@mkdir -p $(PID_DIR)


# ==========
# DEV (FastAPI + Aivis local engine)
# ==========

dev: stop init
	@echo "🚀 Starting local AivisSpeech engine..."
	cd $(AIVIS_DIR) && poetry run python run.py --host 127.0.0.1 --port $(AIVIS_PORT) \
		> ../aivis.log 2>&1 & echo $$! > ../$(PID_AIVIS)

	@echo "🚀 Starting FastAPI (spinning-api)..."
	cd $(API_DIR) && uvicorn main:app --reload --host 127.0.0.1 --port 8931 \
		> ../fastapi.log 2>&1 & echo $$! > ../$(PID_FASTAPI)

	@echo "✨ DEV environment started!"
	@echo " - FastAPI PID: $$(cat $(PID_FASTAPI))"
	@echo " - AivisSpeech PID: $$(cat $(PID_AIVIS))"


# ==========
# START (API only)
# ==========

start: stop init
	@echo "🚀 Starting FastAPI only..."
	cd $(API_DIR) && uvicorn main:app --host 0.0.0.0 --port 8931 \
		> ../fastapi.log 2>&1 & echo $$! > ../$(PID_FASTAPI)

	@echo "✨ FastAPI started."


# ==========
# STOP
# ==========

stop:
	@echo "🛑 Stopping processes..."
	@if [ -f $(PID_FASTAPI) ]; then kill $$(cat $(PID_FASTAPI)) 2>/dev/null || true; rm -f $(PID_FASTAPI); fi
	@if [ -f $(PID_AIVIS) ]; then kill $$(cat $(PID_AIVIS)) 2>/dev/null || true; rm -f $(PID_AIVIS); fi
	@echo "✓ Stopped."


# ==========
# LOGS
# ==========

logs:
	@echo "📜 tail -f logs"
	@tail -f fastapi.log aivis.log
