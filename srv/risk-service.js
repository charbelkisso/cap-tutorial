/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */

const cds = require("@sap/cds");
module.exports = cds.service.impl(async function () {
  this.after("READ", "Risks", (riskData) => {
    const risks = Array.isArray(riskData) ? riskData : [riskData];
    risks.forEach((risk) => {
      if (risk.impact >= 100000) {
        risk.criticality = 1;
      } else {
        risk.criticality = 2;
      }
    });
  });
});
