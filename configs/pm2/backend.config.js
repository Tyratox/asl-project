module.exports = {
  apps: [
    {
      name: "CA backend",
      cwd: "/opt/pm2/asl-ca-backend/",
      script: "ts-node",
      args: "/opt/pm2/asl-ca-backend/src/main.ts",
    },
  ],
};
