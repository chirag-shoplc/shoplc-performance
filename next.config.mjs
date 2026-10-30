/** @type {import('next').NextConfig} */
export default {
  reactStrictMode: true,
  async rewrites() {
    return { beforeFiles: [
      { source: '/', destination: '/monitor.html' },
      { source: '/data.js', destination: '/api/perf-data' }, // same URL the original page loads
    ] };
  },
  async headers() {
    return [{ source: '/monitor.html', headers: [{ key: 'Cache-Control', value: 'no-cache' }] }];
  },
};
