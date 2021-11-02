module.exports = {
  apps: [
    {
      name: "CA backend",
      cwd: "/opt/pm2/asl-ca-backend/",
      script: "ts-node",
      args: "./src/main.ts",
    },
  ],
};
