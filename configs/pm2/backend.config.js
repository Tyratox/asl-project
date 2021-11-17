module.exports = {
  apps: [
    {
      name: "CA backend",
      cwd: "/opt/pm2/asl-ca-backend/",
      script: "/home/webapp/.yarn/bin/ts-node",
      args: "/opt/pm2/asl-ca-backend/src/main.ts",
      out_file: "/dev/null",
      error_file: "/dev/null",
    },
  ],
};
