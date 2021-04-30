include:
  - nodejs-package

njs-user:
  user.present:
    - home:  njs
    - home: /home/njs

git-client-packge:
  pkg.installed:
    - name: git

njs-source:
  git.latest:
    - name: https://github.com/
git
    - rev: master
    - target: /home/ndjs/site
    - require:
      - user: ndj-user
      - pkg: git-client-packge
      - sls: nodejs-package
      
npm-install:
  cmd.wait:
    - name: npm install
    - cwd: /home/njs/site
    - watch:
      - git: ndjs-source

build-script:
  cmd.wait:
    - name: npm run-script build
    - cwd: /home/ndjs/site
    - watch:
      - git: ndjs-source
