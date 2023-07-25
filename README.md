# Code-server-massCode

This project is a dockerfile source for the image that intergates open vscode server, [massCode](https://masscode.io/) and its [extension for vscode](https://marketplace.visualstudio.com/items?itemName=AntonReshetov.masscode-assistant). Taking the advantage of massCode, the image can be deployed as a web IDE that can use customed code snippets.

```mermaid
flowchart BT
subgraph Image
	subgraph IDE
		MassCodePlugin
		VScode
	end
	MassCode-->MassCodePlugin
	CodeSnippets((Code Snippets))-->MassCode
end
```

It is useful when you are a code snippet provider and you want to let your users code with eeb IDE. Or you get used to code in self-hosted web IDE on your cloud server and want to use managed code snippets.

## Usage

As the image built with the [Dockerfile](./Dockerfile) doesn't contain any code, you should take the image as base image and prepare 
code snippets with massCode in your building machine. Copy the massCode folder (the folder is `/home/{your_name}/massCode` by default) to this project directory and your dockerfile may looks like:

```dockerfile
FROM dxsooo/code-server-masscode:1.0

COPY massCode /root/massCode
```

Or just add the COPY command into the [Dockerfile](./Dockerfile) and build your own image.

Deploy with:

```bash
# replace the image with your own and mount your code path
docker run -p8080:8080 -v{your_code_path}:/root/projects dxsooo/code-server-masscode:1.0
```

And the web IDE serves in: http://localhost:8080
