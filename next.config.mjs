/** @type {import('next').NextConfig} */
export default {
  reactStrictMode: true,
  async rewrites() {
    return { beforeFiles: [{ source: '/', destination: '/monitor.html' }] };
  },
  async headers() {
    return [{ source: '/monitor.html', headers: [{ key: 'Cache-Control', value: 'no-cache' }] }];
  },
};
