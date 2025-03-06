#!/usr/bin/env python3

import subprocess
import typer

app = typer.Typer()

@app.command()
def build():
	subprocess.run(["npm", "run", "build"])

@app.command()
def test():
	subprocess.run(["npm", "test"])

@app.command()
def pack():
	subprocess.run(["npm", "pack"])

@app.command()
def publish():
	subprocess.run(["npm", "publish"], check=True)

if __name__ == "__main__":
    app()

