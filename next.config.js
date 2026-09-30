/** @type {import('next').NextConfig} */
const allowedDevOrigins = [];
if (process.env.BASE44_PUBLIC_HOST_SUFFIX) {
  allowedDevOrigins.push("3000-" + process.env.BASE44_PUBLIC_HOST_SUFFIX);
}

module.exports = {
  allowedDevOrigins,
};
