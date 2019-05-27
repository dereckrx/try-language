// Run with
// $ ts-node runner.ts

import {Reptile} from './reptile'
import {Mammal} from './mammal'

const m = new Mammal();
const r = new Reptile();

m.speak();
r.speak();